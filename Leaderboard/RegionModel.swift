//
//  RegionModel.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 18.06.2023.
//

import SwiftUI

struct Region: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let score: Int
    let color: Color
    
    static let shared = Region()
    
    private init() {
        name = ""
        score = 0
        color = .clear
    }
    
    private init(name: String, score: Int, color: Color) {
        self.name = name
        self.score = score
        self.color = color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Region, rhs: Region) -> Bool {
        lhs.id == rhs.id
    }
    
    func createDataSet() -> [[Region]] {
        let global = [
            Region(name: "1", score: 1, color: .blue),
            Region(name: "2", score: 2, color: .red),
            Region(name: "3", score: 3, color: .green),
            Region(name: "4", score: 4, color: .pink),
            Region(name: "5", score: 5, color: .yellow),
        ]
        
        let national = [
            Region(name: "6", score: 6, color: .brown),
            Region(name: "7", score: 7, color: .black),
            Region(name: "8", score: 8, color: .orange),
            Region(name: "9", score: 9, color: .mint),
            Region(name: "10", score: 10, color: .indigo),
        ]
        
        let regions = [
            Region(name: "11", score: 11, color: .cyan),
            Region(name: "12", score: 12, color: .purple),
            Region(name: "13", score: 13, color: .green),
            Region(name: "14", score: 14, color: .blue),
            Region(name: "15", score: 15, color: .red),
        ]
        
        return [global, national, regions]
    }
    
    func createSegmentedPickerTitles() -> [String] {
        return ["Global", "Nationals", "Regions"]
    }
}

