//
//  RunnersUpPedestal.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 26.07.2023.
//

import SwiftUI

struct RunnersUpPedestalView: View {
    let chart: Chart.ChartsViewModel
    
    var body: some View {
        ZStack {
            Image(Assets.foundationPedestal)
                .resizable()
                .scaledToFit()
                .frame(width: Consts.foundationSize.width, height: Consts.foundationSize.height)
                .padding(.top, Consts.foundationPedestalPadding)
            runnersUpViews
        }
    }
    
    @ViewBuilder
    private var runnersUpViews: some View {
        ForEach(chart.runnersUp.indices, id: \.self) { index in
            let region = chart.runnersUp[index]
            RunnersUpDataView(runnerUp: region)
                .padding(index == 1 ? .trailing : .leading, Consts.runnersUpPadding)
        }
    }
}


struct RunnersUpDataView: View {
    let runnerUp: Region
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Spacer()
                Circle()
                    .foregroundColor(Color(hex: runnerUp.color))
                    .frame(width: Consts.circleSize, height: Consts.circleSize)
            }
            
            VStack(alignment: .center) {
                Text(runnerUp.name)
                    .font(.system(size: Consts.nameFontSize))
                IntText(value: runnerUp.score)
            }
            
            Text(runnerUp.username)
                .fontWeight(.light)
                .font(.system(size: Consts.nameFontSize))
                .padding(.bottom, Consts.foundationPedestalPadding)
        }
    }
}
