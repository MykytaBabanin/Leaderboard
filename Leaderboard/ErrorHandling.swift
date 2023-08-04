//
//  ErrorHandling.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 31.07.2023.
//

import Foundation

public enum NetworkError: Error {
    case fileNotFound
    case networkError(Error)
    case decodingError(Error)
}

