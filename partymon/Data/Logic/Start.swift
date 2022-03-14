//
//  Start.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleStartLogic() {
        switch(startState) {
        case .buildTable:
            switch(buttonPress) {
            case .A, .start:
                // show next screen
                gameState = .intro
            case .down:
                // move down
                startState = .openCapTable
            default:
                return
            }
        case .openCapTable:
            switch(buttonPress) {
            case .A, .start:
                // show next screen
                gameState = .capTable
            case .up:
                // move down
                startState = .buildTable
            case .down:
                startState = .openRestart
            default:
                return
            }
        case .openRestart:
            switch(buttonPress) {
            case .A:
                gameState = .restart
            case .up:
                startState = .openCapTable
            default:
                return
            }
        }
    }
}
