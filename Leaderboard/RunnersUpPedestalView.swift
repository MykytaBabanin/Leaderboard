//
//  RunnersUpPedestal.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 26.07.2023.
//

import SwiftUI

struct RunnersUpPedestalView: View {
    let leaders: [Region]
    
    var body: some View {
        ZStack {
            Image(Assets.foundationPedestal)
                .resizable()
                .scaledToFit()
                .frame(width: Consts.foundationSize.width, height: Consts.foundationSize.height)
                .padding(.top, Consts.foundationPedestalPadding)
            RunnersUpDataView(leader: leaders[1])
                .padding(.leading, Consts.runnersUpPadding)
            RunnersUpDataView(leader: leaders[2])
                .padding(.trailing, Consts.runnersUpPadding)
        }
    }
}

struct RunnersUpDataView: View {
    let leader: Region
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Spacer()
                Circle()
                    .foregroundColor(Color(hex: leader.color))
                    .frame(width: Consts.circleSize, height: Consts.circleSize)
            }
            
            VStack(alignment: .center) {
                Text(leader.name)
                    .font(.system(size: Consts.nameFontSize))
                IntText(value: leader.score)
            }
            
            Text(leader.username)
                .fontWeight(.light)
                .font(.system(size: Consts.nameFontSize))
                .padding(.bottom, Consts.foundationPedestalPadding)
        }
    }
}
