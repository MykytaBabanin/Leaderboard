//
//  ChartsModel.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 25.07.2023.
//

import Foundation

enum Chart: Identifiable {
    struct ChartsViewModel {
        let id = UUID()
        let title: String
        var regionList: [Region]
        var runnersUp: [Region]
    }
    
    var regions: [Region] {
        switch self {
        case .global(let chartsViewModel):
            return chartsViewModel.regionList
        case .nationals(let chartsViewModel):
            return chartsViewModel.regionList
        case .regions(let chartsViewModel):
            return chartsViewModel.regionList
        }
    }
    
    var id: UUID {
          switch self {
          case .global(let viewModel):
              return viewModel.id
          case .nationals(let viewModel):
              return viewModel.id
          case .regions(let viewModel):
              return viewModel.id
          }
      }

    case global(ChartsViewModel)
    case nationals(ChartsViewModel)
    case regions(ChartsViewModel)
}

struct Region: Decodable {
    let name: String
    let score: Int
    let color: String
    let username: String
}

typealias LeaderboardData = [String: [Region]]
