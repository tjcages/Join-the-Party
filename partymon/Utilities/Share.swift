//
//  Share.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

func presentShareSheet() {
    guard let urlShare = URL(string: "https://tylerj.me") else { return }
    let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
    let scenes =  UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    window?.rootViewController?.present(activityVC, animated: true, completion: nil)
}
