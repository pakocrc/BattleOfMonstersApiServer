//
//  Battle.swift
//
//
//  Created by Francisco Cordoba on 17/9/24.
//

import Foundation

struct Battle: Codable, Identifiable {
    var id = UUID()
    var winner: Monster?
    var tie: Bool
}

struct BattleBody: Codable {
    var monster1Id: String
    var monster2Id: String
}
