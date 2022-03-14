//
//  CapTable.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct CapTable: View {
    
    @State var writing = false
    let animation = Animation.linear(duration: 2).delay(0.5)
    let animation2 = Animation.linear(duration: 2).delay(3)
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack {
                Spacer()
                
                Image("profOak")
                    .resizable()
                    .frame(width: 140, height: 280)
            }
            .padding([.top, .trailing], .xLarge)
            
            ZStack(alignment: .top) {
                Image("messageBackground")
                    .resizable()
                    .frame(height: 100)
                    .padding([.horizontal, .bottom], .large)
                
                VStack(alignment: .leading, spacing: .medium) {
                    AnimatedText("hello there!", animation: animation)
                    
                    AnimatedText("welcome to party round", animation: animation2)
                }
                .padding([.vertical], .large)
                .padding([.horizontal], .large)
            }
        }
        .onAppear {
            withAnimation(animation) {
                writing.toggle()
            }
        }
    }
}

struct CapTable_Previews: PreviewProvider {
    static var previews: some View {
        CapTable()
    }
}
