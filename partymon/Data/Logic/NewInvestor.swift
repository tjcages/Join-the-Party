//
//  NewInvestor.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleNewInvestorLogic() {
        switch (buttonPress) {
        case .A:
            gameState = .investDex
        default:
            return
        }
    }
}
