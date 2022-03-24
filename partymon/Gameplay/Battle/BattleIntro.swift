//
//  BattleIntro.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct BattleIntro: View {
    @EnvironmentObject var store: DataStore
    
    let investorSize: CGFloat = 124
    
    var body: some View {
        let investor = initialInvestors[store.capTableIndex]
        let investorName = investor.name.components(separatedBy: " ").first ?? ""
        
        let challenger = challengeInvestors[store.investDexIndex]
        let challengerName = challenger.name.components(separatedBy: " ").first ?? ""
        
        VStack {
            Spacer()
            
            HStack(alignment: .center, spacing: .large) {
                VStack {
                    Spacer()
                    
                    ZStack(alignment: .center) {
                        AsyncImage(url: URL(string: investor.image)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.prRed
                        }
                        .frame(width: investorSize, height: investorSize)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.white, lineWidth: 4)
                        )
                        
                        ZStack(alignment: .top) {
                            Image("vsIconBlue")
                                .resizable()
                                .frame(width: 148, height: 120)
                            
                            Text(investorName)
                                .font(.pkLarge)
                                .foregroundColor(.white)
                                .padding([.top], .large)
                        }
                        .padding([.top], investorSize * 2 - .xLarge)
                    }
                }
                
                VStack {
                    ZStack(alignment: .center) {
                        AsyncImage(url: URL(string: challenger.image)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.prRed
                        }
                        .frame(width: investorSize, height: investorSize)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.white, lineWidth: 4)
                        )
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        
                        ZStack(alignment: .top) {
                            Image("vsIconRed")
                                .resizable()
                                .frame(width: 164, height: 130)
                            
                            Text(challengerName)
                                .font(.pkLarge)
                                .foregroundColor(.white)
                                .padding([.top], .large)
                        }
                        .padding([.top], investorSize * 2 - .xLarge)
                    }
                    
                    Spacer()
                }
            }
            
            Spacer()
        }
    }
}

struct BattleIntro_Previews: PreviewProvider {
    static var previews: some View {
        BattleIntro()
    }
}
