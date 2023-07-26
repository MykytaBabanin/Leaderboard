//
//  LeaderboardList.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 26.07.2023.
//

import Foundation
import SwiftUI

struct LeaderboardListView: View {
    @ObservedObject var chartsViewModel: LeaderboardViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                let chart = chartsViewModel.charts[chartsViewModel.selection]
                ForEach(chart.regions, id: \.name) { region in
                    leaderboardRow(for: region)
                }
            }
        }
        .frame(height: Consts.leaderboardListViewSize)
        .background(Color.gray)
        .cornerRadius(Consts.leaderboardCornerRadius)
    }
}

private func leaderboardRow(for region: Region) -> some View {
    HStack {
        Circle()
            .frame(width: Consts.circleSize, height: Consts.circleSize)
            .foregroundColor(Color(hex: region.color))
        
        VStack(alignment: .leading) {
            Text(region.name)
            Text(region.username)
        }
        
        Spacer()
        
        IntText(value: region.score)
    }
    .padding()
}
