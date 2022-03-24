//
//  CapTable.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleCapTableLogic() {
        switch (buttonPress) {
        case .A:
            gameState = .investorDetail
        case .B:
            if (lastGameState == .investDex) {
                // cap table was triggered from menu, go back there first
                gameState = .menu
            } else {
                gameState = lastGameState
            }
        case .start:
            gameState = .menu
        default:
            return
        }
    }
}
