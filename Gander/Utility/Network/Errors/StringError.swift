//
//  StringError.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-21.
//


// MARK: - Optional String Error (For Convenience)
struct StringError: Error {
    var message: String?
    
    init(_ message: String?) {
        self.message = message
    }
}
