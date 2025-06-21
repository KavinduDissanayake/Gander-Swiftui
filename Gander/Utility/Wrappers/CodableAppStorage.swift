//
//  CodableAppStorage.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI
import Combine

@dynamicMemberLookup
@propertyWrapper
final class CodableAppStorage<T: Codable & Sendable>: ObservableObject {
    private let subject: CurrentValueSubject<T, Never>
    private let key: String
    private let queue = DispatchQueue(label: "com.kdMobileApps.CodableAppStoragePublished", attributes: .concurrent)

    public var wrappedValue: T {
        get {
            queue.sync { subject.value }
        }
        set {
            queue.async(flags: .barrier) {
                self.saveToUserDefaults(newValue)
                self.subject.send(newValue)
            }
        }
    }

    public var projectedValue: CodableAppStoragePublisher<T> {
        CodableAppStoragePublisher(subject)
    }

    public init(wrappedValue defaultValue: T, _ key: String) {
        self.key = key

        let stored: T = {
            if let json = UserDefaults.standard.string(forKey: key),
               let data = json.data(using: .utf8),
               let decoded = try? JSONDecoder().decode(T.self, from: data) {
                return decoded
            }
            return defaultValue
        }()

        self.subject = CurrentValueSubject(stored)
    }

    // MARK: - Save

    private func saveToUserDefaults(_ value: T) {
        if let data = try? JSONEncoder().encode(value),
           let json = String(data: data, encoding: .utf8) {
            UserDefaults.standard.set(json, forKey: key)
        }
    }

// MARK: - Publisher Support

public struct CodableAppStoragePublisher<Value: Codable & Sendable>: Combine.Publisher {
    public typealias Output = Value
    public typealias Failure = Never

    let subject: CurrentValueSubject<Value, Never>

    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Value == S.Input {
        subject.subscribe(subscriber)
    }

    init(_ subject: CurrentValueSubject<Value, Never>) {
        self.subject = subject
    }
}

    // MARK: - Dynamic member lookup

    public subscript<U>(dynamicMember keyPath: KeyPath<T, U>) -> U {
        queue.sync { subject.value[keyPath: keyPath] }
    }

    public subscript<U>(dynamicMember keyPath: WritableKeyPath<T, U>) -> U {
        get { queue.sync { subject.value[keyPath: keyPath] } }
        set {
            queue.async(flags: .barrier) {
                var current = self.subject.value
                current[keyPath: keyPath] = newValue
                self.saveToUserDefaults(current)
                self.subject.send(current)
            }
        }
    }
}
