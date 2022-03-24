//
//  Intro.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleIntroLogic() {
        switch (buttonPress) {
        case .A:
            switch (introState) {
            case .welcome:
                introState = .goal
            case .goal:
                introState = .cap
            case .cap:
                introState = .investors
            case .investors:
                introState = .choose
            case .choose:
                introState = .selected
            case .selected:
                // save currently selected investor
                capTableIndex =  introInvestor
                gameState = .investDex
            }
        case .B:
            switch (introState) {
            case .welcome:
                gameState = .start
            case .goal:
                introState = .welcome
            case .cap:
                introState = .goal
            case .investors:
                introState = .cap
            case .choose:
                introState = .investors
            default:
                return
            }
        case .up:
            if introState == .choose {
                if (introInvestor > 0) {
                    introInvestor -= 1
                }
            }
        case .down:
            if (introState == .choose) {
                if (introInvestor < 2) {
                    introInvestor += 1
                }
            }
        case .start:
            lastGameState = .intro
            gameState = .menu
        default:
            return
        }
    }
}
