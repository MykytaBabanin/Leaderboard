//
//  WInnerPedestalView.swift
//  Leaderboard
//
//  Created by Mykyta Babanin on 26.07.2023.
//

import SwiftUI

struct WinnerPedestalView: View {
    let winner: Region
    
    var body: some View {
        ZStack {
            pedestalImage()
            winnerInformation()
        }
        .padding()
    }
    
    private func pedestalImage() -> some View {
        Image(Assets.pedestal)
            .resizable()
            .scaledToFit()
            .frame(width: Consts.pedestalSize.width,
                   height: Consts.pedestalSize.height)
    }
    
    private func winnerInformation() -> some View {
        VStack {
            winnerAvatar()
            winnerScoreAndName()
            winnerUsername()
            Spacer()
        }
    }
    
    private func winnerAvatar() -> some View {
        VStack {
            Image(Assets.crown)
                .frame(width: Consts.crownSize,
                       height: Consts.crownSize)
            Circle()
                .frame(width: Consts.circleSize,
                       height: Consts.circleSize)
                .padding(.bottom, Consts.bottomPadding)
                .foregroundColor(Color(hex: winner.color))
        }
    }
    
    private func winnerScoreAndName() -> some View {
        VStack(alignment: .center) {
            Text(winner.name)
                .font(.system(size: Consts.winnerFontSize))
            IntText(value: winner.score)
        }
        .padding(.bottom, Consts.bottomPadding)
    }
    
    private func winnerUsername() -> some View {
        Text(winner.username)
            .fontWeight(.light)
            .font(.system(size: Consts.nameFontSize))
            .padding(.bottom, Consts.bottomPadding)
    }
}
