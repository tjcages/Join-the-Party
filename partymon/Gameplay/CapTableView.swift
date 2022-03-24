//
//  CapTable.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct CapTableView: View {
    @EnvironmentObject var store: DataStore
    @State private var angle: Double = 0
    
    let logoSize: CGFloat = 56
    let animation = Animation.easeOut(duration: 2).delay(0.5)
    
    let splitInvestors = initialInvestors.chunked(into: 3)
    
    var investorsShown: Int {
        var investorsShownStart = 0
        if (store.capTableIndex > 2) {
            let divided: Float = Float(store.capTableIndex) / Float(3)
            let rounded = Int(floor(divided))
            investorsShownStart = rounded
        }
        return investorsShownStart
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            HStack(alignment: .center) {
                Spacer()
                
                Image("partyRoundLogo")
                    .resizable()
                    .frame(width: logoSize, height: logoSize)
                    .rotationEffect(.degrees(angle))
                
                Text("CapTable")
                    .font(.pkXLarge)
                    .foregroundColor(.textPrimary)
                
                Spacer()
            }
            .padding([.top, .bottom], .large2)
            .padding([.leading, .trailing], .medium2)
            
            VStack(alignment: .leading) {
                ForEach(0..<splitInvestors[investorsShown].count) { i in
                    let multiple = investorsShown * 3
                    InvestorItem(investor: splitInvestors[investorsShown][i], random: false, selected: (store.capTableIndex - multiple) == i)
                }
                
                Spacer()
            }
            .padding(.large)
            .background(Color.gbCasing)
            .cornerRadius(.borderRadiusLarge, corners: [.topLeft, .topRight])
        }
        .background(Color.white)
        .onAppear {
            withAnimation(animation) {
                self.angle += 720
            }
        }
    }
}

struct CapTableView_Previews: PreviewProvider {
    static var previews: some View {
        CapTableView()
    }
}

