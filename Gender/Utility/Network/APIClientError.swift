//
//  APIClientError.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import Foundation
import Alamofire

// MARK: - Custom API Errors
enum APIClientError: Error {
    case noInternetConnection
    case requestFailed
    case decodingFailed
    case serverError(decodedError: ErrorResponse)
    case responseUnsuccessful
    case timeoutException
    case unknownHostException
    case unknownException
    case apiException
    case forbidden
    case scrapingFailed
    case invalidURL
}

// MARK: - Optional String Error (For Convenience)
struct StringError: Error {
    var message: String?
    
    init(_ message: String?) {
        self.message = message
    }
}

// MARK: - Error Response Structure
struct ErrorResponse: Codable, Error {
    let code: Int?
    let message: String?
}

// MARK: - API Client
class APIClient {
    static let shared = APIClient()
    private let session: Session

    private init() {
        self.session = Session()
    }

    // MARK: - Async JSON API Request
    func request<T: Decodable>(
        to endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil,
        timeoutInterval: TimeInterval? = nil
    ) async throws -> T {
        guard let isReachable = NetworkReachabilityManager()?.isReachable, isReachable else {
            throw APIClientError.noInternetConnection
        }

        var urlRequest = try URLRequest(url: endpoint, method: method, headers: headers)
        urlRequest = try encoding.encode(urlRequest, with: parameters)

        if let timeout = timeoutInterval {
            urlRequest.timeoutInterval = timeout
        }

        Logger.log(logType: .info, title: "Request URL", message: "\(endpoint)")

        return try await withCheckedThrowingContinuation { continuation in
            session.request(urlRequest)
                .cURLDescription { description in
                    Logger.log(logType: .info, title: "cURL Request", message: description)
                }
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let decoded):
                        continuation.resume(returning: decoded)
                    case .failure(let error):
                        if let data = response.data,
                           let decodedError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            continuation.resume(throwing: APIClientError.serverError(decodedError: decodedError))
                        } else {
                            Logger.log(logType: .error, message: error.localizedDescription)
                            continuation.resume(throwing: APIClientError.requestFailed)
                        }
                    }
                }
        }
    }
}
