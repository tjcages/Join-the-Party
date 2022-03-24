//
//  Actions.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct Actions: View  {
    @EnvironmentObject var store: DataStore
    
    let animation = Animation.linear(duration: 1)
    let animation2 = Animation.linear(duration: 1).delay(1)
    let animation3 = Animation.linear(duration: 1).delay(2)
    let attack: AttackModel?
    
    init(attack: AttackModel?) {
        self.attack = attack
    }
    
    func getEffectiveness() -> String {
        if let attack = self.attack {
            if (attack.power >= 30) {
                return "super effective!"
            } else if (attack.power >= 15 && attack.power < 30) {
                return "meh effective"
            } else {
                return "not effective"
            }
        } else {
            return "non existent"
        }
    }
    
    var body: some View {
        let investor = initialInvestors[store.capTableIndex]
        let challenger = challengeInvestors[store.investDexIndex]
        
        ZStack(alignment: .top) {
            Image("messageBackgroundInverted")
                .resizable()
                .frame(height: 148)
                .padding([.horizontal], .medium)
            
            HStack {
                VStack(alignment: .leading, spacing: .medium) {
                    switch (store.battleState) {
                    case .battle:
                        ForEach(0..<investor.attacks.count, id: \.self) { i in
                            GameButton(investor.attacks[i].name, animation: animation, selected: store.battleIndex == i)
                        }
                    case .attack:
                        AnimatedText("\(investor.name) used", color: .white, animation: animation)
                        
                        AnimatedText("\(attack?.name ?? "shit I forgot")", color: .white, animation: animation2)
                        
                        AnimatedText("and it was \(getEffectiveness())", color: .white, animation: animation3)
                    case .defend:
                        AnimatedText("\(challenger.name) used", color: .white, animation: animation)
                        
                        AnimatedText("\(attack?.name ?? "who are you?")", color: .white, animation: animation2)
                        
                        AnimatedText("and it was \(getEffectiveness())", color: .white, animation: animation3)
                    case .win:
                        AnimatedText("\(challenger.name) was convinced!", color: .white, animation: animation)
                        
                    case .loss:
                        AnimatedText("\(challenger.name) was not convinced", color: .white, animation: animation)
                        
                    default:
                        VStack {}
                    }
                }
                .padding([.top], .small)
                
                Spacer()
            }
            .padding([.leading], 40)
            .padding([.top], .large)
        }
    }
}
