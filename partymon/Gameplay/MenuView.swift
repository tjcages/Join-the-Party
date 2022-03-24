//
//  MenuView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var store: DataStore
    @State var titleVisible = true
    
    let textAnimation = Animation.linear(duration: 0)
    
    private let animation = Animation.linear(duration: 0.2).delay(Double(Float.random(in: 3..<12))).repeatForever(autoreverses: false)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            Text("Menu")
                .font(.pkXLarge)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(.medium2)
                .padding(.large2)
                .opacity(titleVisible ? 1 : 0)
                .onAppear {
                    withAnimation(self.animation) {
                        titleVisible.toggle()
                    }
                }
            
            GameButton("See your cap table", animation: textAnimation, selected: store.menuState == .capTable)
                .padding(.medium)
            
            GameButton("Moonshot progress", animation: textAnimation, selected: store.menuState == .progress)
                .padding(.medium)
            
            GameButton("Walk away", animation: textAnimation, selected: store.menuState == .exit)
                .padding(.medium)
            
            GameButton("Close menu", animation: textAnimation, selected: store.menuState == .close)
                .padding(.medium)
            
            Spacer()
        }
        .background(Color.gbCasing)
    }
}
