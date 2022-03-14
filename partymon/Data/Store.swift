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
    @Published private(set) var gameState: GameState
    @Published private(set) var startState: StartState
    @Published private(set) var introState: IntroState
    @Published private(set) var battleState: BattleState
    
    // handle menu state
    @Published private(set) var menuState: MenuState
    @Published private(set) var lastGameState: GameState
    
    @Published private(set) var restartState: RestartState
    
    @Published private(set) var introInvestor: Int
    @Published private(set) var capTableIndex: Int
    @Published private(set) var investDexIndex: Int
    @Published private(set) var battleIndex: Int
    
    @Published private var buttonPress: ButtonState {
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
                    print("nada")
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
                    print("nada")
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
    
    private func handleStartLogic() {
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
    
    private func handleIntroLogic() {
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
            case .selected:
                print("No luck, Chuck")
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
            print("Nothing")
        }
    }
    
    private func handleBattleLogic() {
        switch (buttonPress) {
        case .B:
            switch (battleState) {
            case .intro:
                gameState = .investDex
            case .attack:
                NotificationCenter.default.post(name: NSNotification.defend, object: nil)
                battleState = .defend
            case .defend:
                battleState = .battle
            case .win:
                gameState = .newInvestor
                battleState = .intro
            case .loss:
                gameState = .investDex
                battleState = .intro
            default:
                return
            }
        case .A:
            switch (battleState) {
            case .intro:
                battleState = .battle
            case .battle:
                NotificationCenter.default.post(name: NSNotification.attack, object: nil)
                battleState = .attack
            case .attack:
                NotificationCenter.default.post(name: NSNotification.defend, object: nil)
                battleState = .defend
            case .defend:
                battleState = .battle
            case .win:
                gameState = .newInvestor
                battleState = .intro
            case .loss:
                gameState = .investDex
                battleState = .intro
            }
        case .up:
            if (battleState == .battle) {
                if (battleIndex > 0) {
                    battleIndex -= 1
                }
            }
        case .down:
            if (battleState == .battle) {
                if (battleIndex < 2) {
                    battleIndex += 1
                }
            }
        case .start:
            lastGameState = .battle
            gameState = .menu
        default:
            return
        }
    }
    
    public func battleWin() {
        battleState = .win
    }
    
    public func battleLoss() {
        battleState = .loss
    }
    
    private func handleNewInvestorLogic() {
        switch (buttonPress) {
        case .A:
            gameState = .investDex
        default:
            return
        }
    }
    
    private func handleInvestorDetailLogic() {
        switch (buttonPress) {
        case .A:
            print("Selecting")
        case .B:
            gameState = .capTable
        default:
            return
        }
    }
    
    private func handleMenuLogic() {
        switch (buttonPress) {
        case .up:
            switch (menuState) {
            case .capTable:
                return
            case .progress:
                menuState = .capTable
            case .exit:
                menuState = .progress
            case .close:
                menuState = .exit
            }
        case .down:
            switch (menuState) {
            case .capTable:
                menuState = .progress
            case .progress:
                menuState = .exit
            case .exit:
                menuState = .close
            case .close:
                return
            }
        case .A:
            switch (menuState) {
            case .capTable:
                gameState = .capTable
            case .progress:
                gameState = .progress
            case .exit:
                gameState = .start
                lastGameState = .start
                battleState = .intro
            case .close:
                gameState = lastGameState
            }
        case .B:
            gameState = lastGameState
        default:
            return
        }
    }
    
    private func handleProgressLogic() {
        switch (buttonPress) {
        case .B:
            gameState = .menu
        default:
            return
        }
    }
    
    private func handleRestartLogic() {
        switch (buttonPress) {
        case .up:
            if (restartState == .no) {
                restartState = .yes
            }
        case .down:
            if (restartState == .yes) {
                restartState = .no
            }
        case .A:
            switch(restartState) {
            case .yes:
                print("RESTARTING")
                gameState = .start
            case .no:
                gameState = .start
            }
        case .B:
            gameState = .start
        default:
            return
        }
    }
    
    private func handleCapTableLogic() {
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
    
    private func handleInvestDexLogic() {
        switch (buttonPress) {
        case .A:
            gameState = .battle
        case .start:
            lastGameState = .investDex
            gameState = .menu
        default:
            return
        }
    }
}
