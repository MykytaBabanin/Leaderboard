//
//  ContentView.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 17.06.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var chartsViewModel = LeaderboardViewModel()
    @State private var selection = 0

    var body: some View {
        VStack {
            if !chartsViewModel.charts.isEmpty {
                segmentedPickerView()
                Spacer()
                PedestalView(chartsViewModel: chartsViewModel)
                    .padding(.top, Consts.pedestalPadding)
                LeaderboardListView(chartsViewModel: chartsViewModel)
            } else {
                ProgressView()
            }
        }
        .padding()
    }
    
    private func segmentedPickerView() -> some View {
        Picker("", selection: $chartsViewModel.selection) {
            ForEach(chartsViewModel.charts.indices, id: \.self) {   index in
                Text(title(for: chartsViewModel.charts[index]))
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
    
    private func title(for charts: Chart) -> String {
        switch charts {
        case .global(let viewModel):
            return viewModel.title
        case .nationals(let viewModel):
            return viewModel.title
        case .regions(let viewModel):
            return viewModel.title
        }
    }
}
