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
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let decodedData = try await decoder.decode(T.self, from: data)
        return decodedData
    }
}

enum NetworkResource {
    case bundle(name: String, fileExtension: String)
    case url(URL)
    
    static let bundleResource = NetworkResource.bundle(name: "Score", fileExtension: "json")
    
    func getURL() throws -> URL {
        switch self {
        case .bundle(let name, let fileExtension):
            guard let bundle = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
                throw NetworkError.fileNotFound
            }
            return bundle
        case .url(let url):
            return url
        }
    }
}
