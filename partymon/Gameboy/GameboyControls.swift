//
//  GameboyControls.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct GameboyControls: View {
    
    let buttonSize: CGFloat = 72
    let numpadSize: CGFloat = 164
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Spacer()
                
                Text("party round")
                    .font(Font.pkMedium)
                    .foregroundColor(.textSecondary)
                
                Spacer()
            }
            .padding(.large)
            .background(LinearGradient(gradient: Gradient(colors: [.black, .gbCasing]), startPoint: .top, endPoint: .bottom))
            .border(width: 5, edges: [.top], color: .black)
            .cornerRadius(.borderRadiusLarge, corners: [.bottomLeft, .bottomRight])
            .shadow(radius: 20)
            
            HStack {
                GameboyNumpad()
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        
                        GameboyButton(type: "A")
                    }
                    
                    GameboyButton(type: "B")
                        .padding([.trailing], buttonSize)
                }
            }
            .padding([.leading, .trailing], .large)
            .padding([.bottom], .medium)
            
            HStack(alignment: .center, spacing: .xLarge) {
                GameboyButton(type: "share")
                
                GameboyButton(type: "start")
            }
            .frame(maxWidth: .infinity)
            .padding([.bottom], .xLarge)
                
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.prRed2, .prRed]), startPoint: .top, endPoint: .bottom)
        )
        .frame(minHeight: 424)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct GameboyControls_Previews: PreviewProvider {
    static var previews: some View {
        GameboyControls()
    }
}
