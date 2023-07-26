//
//  RegionModel.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 18.06.2023.
//

import SwiftUI

protocol LeaderboardProvider: AnyObject {
    func retreiveCharts() async throws -> [Chart]
    func setupCharts(leaderboardData: LeaderboardData) -> [Chart]
}

final class LeaderboardViewModel: LeaderboardProvider, ObservableObject {
    @Published var selection: Int = 0
    
    var charts: [Chart] = []
    var leaders: [Region] = []
    
    init() {
        Task {
            do {
                self.charts = try await retreiveCharts()
                self.leaders = leaders.sorted(by: { $0.score > $1.score })
            } catch {
                print(error)
            }
        }
    }
    
    
    func retreiveCharts() async throws -> [Chart] {
        guard let url = Bundle.main.url(forResource: "Score", withExtension: "json") else {
            return []
        }
        
        let data = try await NetworkManager.shared.fetchData(from: url)
        let decoder = JSONDecoder()
        let leaderboardData = try await decoder.decode(LeaderboardData.self, from: data)
        let charts = setupCharts(leaderboardData: leaderboardData)
        return charts
    }
    
    func setupCharts(leaderboardData: LeaderboardData) -> [Chart] {
        var charts: [Chart] = []
        
        for (title, regions) in leaderboardData {
            guard let leaderId = findHighestScoreRegion(in: regions) else { return [] }
            leaders.append(leaderId)
            
            var chartsViewModel = Chart.ChartsViewModel(title: title, leaderId: leaderId, lists: regions)
            chartsViewModel.lists = chartsViewModel.sortedList
            
            switch title {
            case "Global":
                charts.append(.global(chartsViewModel))
            case "Nationals":
                charts.append(.nationals(chartsViewModel))
            case "Regions":
                charts.append(.regions(chartsViewModel))
            default: break
            }
        }
        
        return charts
    }
    
    private func findHighestScoreRegion(in dataSet: [Region]) -> Region? {
        return dataSet.max(by: { $0.score < $1.score })
    }
}

