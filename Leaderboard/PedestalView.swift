//
//  PedestalView.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 18.06.2023.
//

import SwiftUI

struct PedestalView: View {
    let dataSet: [[Region]]
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                RunnersUpPedestalView(dataSet: dataSet)
                LeaderPedestalView(dataSet: dataSet[0])
            }
        }
    }
}

struct LeaderPedestalView: View {
    let dataSet: [Region]
    
    var body: some View {
        ZStack {
            Image(.pedestal)
                .resizable()
                .scaledToFit()
                .frame(width: 122, height: 159)
            
            VStack {
                if let highestScoreRegion = Region.findHighestScoreRegion(in: dataSet) {
                    VStack {
                        Image(.crown)
                            .frame(width: 20, height: 20)
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 20)
                            .foregroundColor(highestScoreRegion.color)
                    }
                    
                    VStack(alignment: .center) {
                        Text(highestScoreRegion.name)
                        Text("\(highestScoreRegion.score)")
                    }
                    .padding(.bottom, 20)
                    
                    
                    Spacer()
                    
                    Text("@username")
                        .fontWeight(.light)
                        .font(.system(size: 11))
                        .padding(.bottom, 40)
                }
            }
            .padding()
        }
    }
}

struct RunnersUpPedestalView: View {
    let dataSet: [[Region]]
    
    var body: some View {
        ZStack {
            Image(.foundationPedestal)
                .resizable()
                .scaledToFit()
                .frame(width: 342, height: 113)
                .padding(.top, 45)
            RunnersUpDataView(dataSet: dataSet[1])
                .padding(.leading, 240)
            RunnersUpDataView(dataSet: dataSet[2])
                .padding(.trailing, 240)
        }
    }
}

struct RunnersUpDataView: View {
    let dataSet: [Region]
    
    var body: some View {
        VStack {
            if let highestScoreRegion = Region.findHighestScoreRegion(in: dataSet) {
                Spacer()
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(highestScoreRegion.color)
                }
                
                VStack(alignment: .center) {
                    Text(highestScoreRegion.name)
                    Text("\(highestScoreRegion.score)")
                }
                
                Text("@username")
                    .fontWeight(.light)
                    .font(.system(size: 11))
                    .padding(.bottom, 60)
            }
        }
    }
}

extension Region {
    static func findHighestScoreRegion(in dataSet: [Region]) -> Region? {
        return dataSet.max(by: { $0.score < $1.score })
    }
}
