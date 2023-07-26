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
        let leaderId: Region
        var lists: [Region]
        
        var sortedList: [Region] {
            return lists.sorted { $0.score > $1.score }
        }
    }
    
    var regions: [Region] {
        switch self {
        case .global(let chartsViewModel):
            return chartsViewModel.lists
        case .nationals(let chartsViewModel):
            return chartsViewModel.lists
        case .regions(let chartsViewModel):
            return chartsViewModel.lists
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
