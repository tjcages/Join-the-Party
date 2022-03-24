//
//  InvestorData.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

enum Rarity: String {
    case common
    case hard
    case rare
    case unknown
}

struct InvestorModel: Identifiable {
    let id = UUID()
    let name: String
    let rarity: Rarity
    let company: String
    let image: String
    let attacks: [AttackModel]
}

struct AttackModel: Identifiable {
    let id = UUID()
    let name: String
    let power: Int
}

let initialInvestors = [
    InvestorModel(name: "Packy McCormick", rarity: .common, company: "Not boring", image: "https://helpfulvcs.com/imgs/PR_VC_Packy_McCormick_a_900.png", attacks: [AttackModel(name: "Send pitch deck", power: 25), AttackModel(name: "It's consumer behavior", power: 15), AttackModel(name: "Web 3.0", power: 30)]),
    InvestorModel(name: "Nik Sharma", rarity: .common, company: "Sharma brands", image: "https://helpfulvcs.com/imgs/PR_VC_Nik_Sharma_a_900.png", attacks: [AttackModel(name: "Best thing since sliced bread", power: 30), AttackModel(name: "Go where you customers are", power: 20), AttackModel(name: "Trust the process", power: 20)]),
    InvestorModel(name: "Justin Kan", rarity: .common, company: "Twitch", image: "https://helpfulvcs.com/imgs/PR_VC_Justin_Kan_b_900.png", attacks: [AttackModel(name: "Spiritual retreats", power: 15), AttackModel(name: "Just vibes", power: 30), AttackModel(name: "Did it once, can do it again", power: 30)]),
]

let challengeInvestors = [
    InvestorModel(name: "Paul Graham", rarity: .hard, company: "YCombinator", image: "https://helpfulvcs.com/imgs/PR_VC_Paul_Graham_a_900.png", attacks: [AttackModel(name: "Talk to your customers", power: 25), AttackModel(name: "Talk to your customers", power: 35), AttackModel(name: "Talk to your customers", power: 45)]),
    InvestorModel(name: "Adam Draper", rarity: .hard, company: "Boost VC", image: "https://helpfulvcs.com/imgs/PR_VC_Adam_Draper_a_900.png", attacks: [AttackModel(name: "Talk to your customers", power: 25), AttackModel(name: "Let me see those numbers", power: 50), AttackModel(name: "Keep up the good work", power: 40)]),
    InvestorModel(name: "Logan Bartlett", rarity: .rare, company: "Redpoint", image: "https://helpfulvcs.com/imgs/PR_VC_Logan_Bartlett_a_900.png", attacks: [AttackModel(name: "IDK", power: 10), AttackModel(name: "*Tweets mid conversation*", power: 45), AttackModel(name: "It's good, but it's not for me", power: 45)]),
    InvestorModel(name: "Gabby Goldberg", rarity: .rare, company: "TCG Crypto", image: "https://helpfulvcs.com/imgs/PR_VC_Gaby_Goldberg_a_900.png", attacks: [AttackModel(name: "Who are you?", power: 55), AttackModel(name: "Do you understand blockchain?", power: 20), AttackModel(name: "Who are your competitors", power: 25)]),
    InvestorModel(name: "Alfred Lin", rarity: .rare, company: "Sequoia", image: "https://helpfulvcs.com/imgs/PR_VC_Alfred_Lin_a_900.png", attacks: [AttackModel(name: "No, just no", power: 60), AttackModel(name: "Tell me something I don't know", power: 30), AttackModel(name: "Let me give it a thought", power: 30)]),
    InvestorModel(name: "Austin Reif", rarity: .hard, company: "Morning Brew", image: "https://helpfulvcs.com/imgs/PR_VC_Austin_Reif_b_900.png", attacks: [AttackModel(name: "Have you read the morning brew?", power: 10), AttackModel(name: "Do you have an MBA?", power: 35), AttackModel(name: "Who knows about this?", power: 25)])
]

