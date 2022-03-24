//
//  Battle.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct Battle: View {
    @EnvironmentObject var store: DataStore
    
    @State private var investorHealth = 100
    @State private var challengerHealth = 100
    
    @State private var currentAttack: AttackModel?
    
    let investorSize: CGFloat = 64
    
    var investorPercentage: CGFloat {
        var percentage = CGFloat(investorHealth) / 100
        if (percentage < 0) { percentage = 0 }
        return percentage
    }
    
    var challengerPercentage: CGFloat {
        var percentage = CGFloat(challengerHealth) / 100
        if (percentage < 0) { percentage = 0 }
        return percentage
    }
    
    func handleUserAttack() {
        // perform attack and reduce opponent's health
        let investor = initialInvestors[store.capTableIndex]
        let attack = investor.attacks[store.battleIndex]
        currentAttack = attack
        challengerHealth -= attack.power
        
        if (challengerHealth <= 0) {
            challengerHealth = 0
        }
    }
    
    func handleChallengerAttack() {
        // detect opponents health to determine win/loss
        if (challengerHealth <= 0) {
            // battle over! you win
            store.battleWin()
            return
        }
        
        // perform attack and reduce opponent's health
        let attack = getRandomAttack()
        currentAttack = attack
        investorHealth -= attack.power
        
        if (investorHealth <= 0) {
            investorHealth = 0
            // battle over! you lose
            store.battleLoss()
            return
        }
    }
    
    func getRandomAttack() -> AttackModel {
        let challenger = challengeInvestors[store.investDexIndex]
        let randomInt = Int.random(in: 0..<challenger.attacks.count - 1)
        let attack = challenger.attacks[randomInt]
        return attack
    }
    
    var body: some View {
        let investor = initialInvestors[store.capTableIndex]
        let challenger = challengeInvestors[store.investDexIndex]
        
        
        VStack {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            HStack(alignment: .center, spacing: .medium) {
                Spacer()
                
                VStack(alignment: .trailing, spacing: .medium) {
                    Text(challenger.name)
                        .font(.pkLarge)
                        .foregroundColor(.white)
                        .padding([.top], .large)
                    
                    HStack {
                        Text("\(challengerHealth) HP:")
                            .font(.pkSmall)
                            .foregroundColor(.white)
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.textSecondary)
                                
                                Rectangle()
                                    .fill(Color.prRed)
                                    .frame(width: geometry.size.width * challengerPercentage)
                            }
                        }
                        .frame(width: 164, height: 10)
                    }
                }
                
                AsyncImage(url: URL(string: challenger.image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.prRed
                }
                .frame(width: investorSize, height: investorSize)
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.white, lineWidth: 2)
                )
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            .padding([.horizontal], .large)
            
            Spacer()
            
            HStack(alignment: .center, spacing: .medium) {
                AsyncImage(url: URL(string: investor.image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.prRed
                }
                .frame(width: investorSize, height: investorSize)
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.white, lineWidth: 2)
                )
                
                VStack(alignment: .leading, spacing: .medium) {
                    Text(investor.name)
                        .font(.pkLarge)
                        .foregroundColor(.white)
                        .padding([.top], .large)
                    
                    HStack {
                        Text("\(investorHealth) HP:")
                            .font(.pkSmall)
                            .foregroundColor(.white)
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.textSecondary)
                                
                                Rectangle()
                                    .fill(Color.prRed)
                                    .frame(width: geometry.size.width * investorPercentage)
                            }
                        }
                        .frame(width: 164, height: 10)
                    }
                }
                
                Spacer()
            }
            .padding([.horizontal], .large)
            .padding([.bottom], .medium)
            
            Actions(attack: currentAttack)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.attack)) { _ in
            handleUserAttack()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.defend)) { _ in
            handleChallengerAttack()
        }
    }
}

struct Battle_Previews: PreviewProvider {
    static var previews: some View {
        Battle()
    }
}

