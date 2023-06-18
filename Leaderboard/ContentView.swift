//
//  ContentView.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 17.06.2023.
//

import SwiftUI

struct ContentView: View {
    private let dataSet = Region.shared.createDataSet()
    private let segmentedTitles = Region.shared.createSegmentedPickerTitles()
    @State private var selection = 0
    
    var body: some View {
        VStack {
            segmentedPickerView()
            
            Spacer()

            PedestalView(dataSet: dataSet)
                .padding(.top, 40)
            
            leaderboardScrollView()
        }
        .padding()
    }
    
    private func segmentedPickerView() -> some View {
        Picker("", selection: $selection) {
            ForEach(0..<dataSet.count, id: \.self) { index in
                Text(segmentedTitles[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
    
    private func leaderboardScrollView() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(dataSet[selection].sorted { $0.score > $1.score }, id: \.self) { region in
                    leaderboardRow(for: region)
                }
            }
        }
        .frame(height: 400)
        .background(Color.gray)
        .cornerRadius(40)
    }
    
    private func leaderboardRow(for region: Region) -> some View {
        HStack {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(region.color)
            
            VStack(alignment: .leading) {
                Text(region.name)
                Text("@username")
            }
            
            Spacer()
            
            Text("\(region.score)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
