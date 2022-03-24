//
//  DataStore.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import Foundation
import Combine

typealias DataStore = Store<DataState>

class Store<DataState>: ObservableObject {
    @Published var gameState: GameState
    @Published var startState: StartState
    @Published var introState: IntroState
    @Published var battleState: BattleState
    
    // handle menu state
    @Published var menuState: MenuState
    @Published var lastGameState: GameState
    
    @Published var restartState: RestartState
    
    @Published var introInvestor: Int
    @Published var capTableIndex: Int
    @Published var investDexIndex: Int
    @Published var battleIndex: Int
    
    @Published var buttonPress: ButtonState {
        didSet {
            if (buttonPress == .share) {
                presentShareSheet()
            }
            
            // modify overall game state
            switch(gameState) {
            case .start:
                handleStartLogic()
            case .intro:
                handleIntroLogic()
            case .capTable:
                handleCapTableLogic()
            case .investDex:
                handleInvestDexLogic()
            case .battle:
                handleBattleLogic()
            case .newInvestor:
                handleNewInvestorLogic()
            case .investorDetail:
                handleInvestorDetailLogic()
            case .menu:
                handleMenuLogic()
            case .progress:
                handleProgressLogic()
            case .restart:
                handleRestartLogic()
            }
            
            // for captable, navigate the list
            if (gameState == .capTable) {
                switch(buttonPress) {
                case .down:
                    if (capTableIndex < initialInvestors.count - 1) { // TODO CHANGE THE INVESTORS SHOWN
                        capTableIndex += 1
                    }
                case .up:
                    if (capTableIndex > 0) {
                        capTableIndex -= 1
                    }
                default:
                    return
                }
            }
            
            // for investdex, navigate the list
            if (gameState == .investDex) {
                switch(buttonPress) {
                case .down:
                    if (investDexIndex < challengeInvestors.count - 1) { // TODO CHANGE THE INVESTORS SHOWN
                        investDexIndex += 1
                    }
                case .up:
                    if (investDexIndex > 0) {
                        investDexIndex -= 1
                    }
                default:
                    return
                }
            }
        }
    }
    
    init() {
        // gameplay
        self.gameState = .start
        self.startState = .buildTable
        self.introState = .welcome
        self.menuState = .capTable
        self.lastGameState = .start
        self.restartState = .no
        self.battleState = .intro
        
        self.introInvestor = 0
        
        // controls
        self.buttonPress = .none
        self.capTableIndex = 0
        self.investDexIndex = 0
        self.battleIndex = 0
    }
    
    func buttonPressed(button: ButtonState) {
        buttonPress = button
    }
}
