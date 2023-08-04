//
//  PedestalView.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 18.06.2023.
//

import SwiftUI

struct PedestalView: View {
    @ObservedObject var chartsViewModel: LeaderboardViewModel
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                if let chart = chartsViewModel.currentChart,
                   let winner = chart.regionList.first {
                    RunnersUpPedestalView(chart: chart)
                    WinnerPedestalView(winner: winner)
                }
            }
        }
    }
}
