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
                RunnersUpPedestalView(leaders: chartsViewModel.leaders)
                WinnerPedestalView(winner: chartsViewModel.leaders[0])
            }
        }
    }
}
