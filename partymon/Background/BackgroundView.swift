//
//  Background.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct BackgroundView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            ColorGrid()
                .frame(height: 264)
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.black, .gbCasing]), startPoint: .top, endPoint: .bottom))
                
                Image("danceGrid")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
            }

        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

