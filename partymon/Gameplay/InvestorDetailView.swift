//
//  InvestorDetailView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

struct InvestorDetailView: View {
    @EnvironmentObject var store: DataStore
    
    let animation = Animation.linear(duration: 2)
    let animation2 = Animation.linear(duration: 0)
    
    var body: some View {
        let investor = initialInvestors[store.capTableIndex]
        let investorName = investor.name.components(separatedBy: " ").first ?? ""
        
        ZStack(alignment: .bottom) {
            VStack {
                AsyncImage(url: URL(string: investor.image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.prRed
                }
//                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fill)
            }
            
            VStack(alignment: .center, spacing: .medium) {
                Text(investor.name)
                    .font(.pkLarge)
                    .foregroundColor(.white)
                    .padding([.bottom], .small)
                
                Text(investor.rarity.rawValue)
                    .font(.pkSmall)
                    .foregroundColor(.black)
                    .padding([.vertical], 4)
                    .padding([.horizontal], .medium)
                    .background(getColor(rarity: investor.rarity))
                    .padding([.bottom], .medium)
                
                GameButton("Set \(investorName) as lead investor", animation: animation2, selected: true)
            }
            .padding(.large)
            .background(Color.gbCasing)
            .cornerRadius(.borderRadiusLarge, corners: [.topLeft, .topRight])
        }
        .background(.white)
    }
}

struct InvestorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InvestorDetailView()
    }
}
