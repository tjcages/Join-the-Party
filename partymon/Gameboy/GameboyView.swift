//
//  GameboyView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct GameboyView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.gbCasing, .black]), startPoint: .top, endPoint: .bottom))
                .border(width: 5, edges: [.bottom], color: .black)
                .frame(height: 124)
                .zIndex(1)
                .edgesIgnoringSafeArea(.top)
            
            BackgroundView()
        }
    }
}

struct GameboyView_Previews: PreviewProvider {
    static var previews: some View {
        GameboyView()
    }
}
