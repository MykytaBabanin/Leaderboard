//
//  RegionModel.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 18.06.2023.
//

import SwiftUI

protocol LeaderboardProvider: AnyObject {
    func retreiveCharts(from resource: NetworkResource) async throws -> [Chart]
    func setupCharts(leaderboardData: LeaderboardData) -> [Chart]
}

final class LeaderboardViewModel: LeaderboardProvider, ObservableObject {
    @Published var selection: Int = 0
    
    var charts: [Chart] = []
    
    var currentChart: Chart.ChartsViewModel? {
        guard selection >= 0 && selection < charts.count else {
            return nil
        }
        
        switch charts[selection] {
        case .global(let viewModel):
            return viewModel
        case .nationals(let viewModel):
            return viewModel
        case .regions(let viewModel):
            return viewModel
        }
    }
    
    init() {
        Task {
            self.charts = try await retreiveCharts(from: NetworkResource.bundleResource)
        }
    }
    
    func retreiveCharts(from resource: NetworkResource) async throws -> [Chart] {
        do {
            let url = try resource.getURL()
            do {
                let data: LeaderboardData = try await NetworkManager.shared.fetchData(from: url)
                let charts = setupCharts(leaderboardData: data)
                return charts
            } catch let networkError {
                throw NetworkError.networkError(networkError)
            }
        } catch let decodingError {
            throw NetworkError.decodingError(decodingError)
        }
    }
    
    func setupCharts(leaderboardData: LeaderboardData) -> [Chart] {
        var charts: [Chart] = []
        
        for (title, regions) in leaderboardData {
            let sortedRegions = sortRegions(regions)
            let runnersUp = findRunnersUp(sortedRegions)
            let chartsViewModel = Chart.ChartsViewModel(title: title, regionList: sortedRegions, runnersUp: runnersUp)
    
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
    
    private func sortRegions(_ regions: [Region]) -> [Region] {
        return regions.sorted(by: {$0.score > $1.score })
    }
    
    private func findRunnersUp(_ sortedRegions: [Region]) -> [Region] {
        return Array(sortedRegions.dropFirst().prefix(2))
    }
}

