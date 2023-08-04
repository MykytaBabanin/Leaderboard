//
//  NetworkManager.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 26.07.2023.
//

import Foundation

public class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
