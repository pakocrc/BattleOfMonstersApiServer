//
//  Monster.swift
//
//
//  Created by Francisco Cordoba on 17/9/24.
//

import Foundation
import Vapor

struct Monster: Codable, Identifiable {
    var id: String
    var name: String
    var attack: Int
    var defense: Int
    var hp: Int
    var speed: Int
    var type: String
    var imageUrl: URL
}
