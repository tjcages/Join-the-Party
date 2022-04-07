//
//  ContentView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: DataStore
    
    var body: some View {
        VStack(spacing: 0) {
            GameboyView()
            
            GameboyControls()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
