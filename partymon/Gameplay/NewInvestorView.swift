//
//  NewInvestorView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct NewInvestorView: View {
    @EnvironmentObject var store: DataStore
    
    let investorSize: CGFloat = 124
    
    var body: some View {
        let investor = challengeInvestors[store.investDexIndex]
        
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            Text("Investor added!")
                .font(.pkXLarge)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(.medium2)
                .padding(.large2)
            
            Text("Congrats! \(investor.name) was added to your cap table")
                .font(.pkMedium)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.medium)
                .padding([.bottom], .large)
            
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
            
            Spacer()
        }
        .background(Color.gbCasing)
    }
}
