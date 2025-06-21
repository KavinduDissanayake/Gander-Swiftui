//
//  APIClientError.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-21.
//
import Foundation

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



// MARK: - Localized Error Support
extension APIClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No internet connection."
        case .requestFailed:
            return "The request failed."
        case .decodingFailed:
            return "Failed to decode the response."
        case .serverError(let decodedError):
            return decodedError.message ?? "Server returned an error."
        case .responseUnsuccessful:
            return "The response was unsuccessful."
        case .timeoutException:
            return "The request timed out."
        case .unknownHostException:
            return "Unable to resolve host."
        case .unknownException:
            return "An unknown error occurred."
        case .apiException:
            return "An API exception occurred."
        case .forbidden:
            return "Access is forbidden."
        case .scrapingFailed:
            return "Failed to scrape article data."
        case .invalidURL:
            return "Invalid URL."
        }
    }
}
