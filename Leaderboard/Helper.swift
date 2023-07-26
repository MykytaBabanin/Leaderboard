//
//  Helper.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 26.07.2023.
//

import Foundation
import SwiftUI

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = (rgb & 0xff0000) >> 16
        let g = (rgb & 0x00ff00) >> 8
        let b = rgb & 0x0000ff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff
        )
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) async throws -> T {
        return try await withCheckedThrowingContinuation({ continuation in
            DispatchQueue.global().async {
                do {
                    let decodedData = try self.decode(T.self, from: data)
                    continuation.resume(returning: decodedData)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}

struct IntText: View {
    var value: Int

    var body: some View {
        Text("\(value)")
    }
}
