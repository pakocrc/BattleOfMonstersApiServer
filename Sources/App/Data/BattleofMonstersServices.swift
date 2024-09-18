//
//  BattleofMonstersServices.swift
//
//
//  Created by Francisco Cordoba on 17/9/24.
//

import Foundation
import Vapor

protocol Services {
    static func getMonsters() -> String
    static func battle(battleBody: BattleBody) -> String
}

final class BattleofMonstersServices: Services {
    static func getMonsters() -> String {
        var apiResponse = ApiResponse(statusCode: 500, errorMessage: ServiceError.unexpectedError.localizedDescription)
        var jsonResponse = try! JSONEncoder().encode(apiResponse)

        do {
            guard let fileResource = Bundle.module.url(forResource: "monsters", withExtension: "json") else {
                throw ServiceError.noDataReceived
            }

            let data = try! Data(contentsOf: fileResource)
            let monsters = try! JSONDecoder().decode([Monster].self, from: data)
            
            apiResponse = ApiResponse(statusCode: 200, monsters: monsters)

        } catch {
            apiResponse = ApiResponse(statusCode: 500, errorMessage: error.localizedDescription)
        }

        jsonResponse = try! JSONEncoder().encode(apiResponse)
        return String(data: jsonResponse, encoding: .utf8) ?? ""
    }

    static func battle(battleBody: BattleBody) -> String {
        var apiResponse = BattleApiResponse(statusCode: 500, errorMessage: ServiceError.unexpectedError.localizedDescription)
        var jsonResponse = try! JSONEncoder().encode(apiResponse)

        do {
            guard let fileResource = Bundle.module.url(forResource: "monsters", withExtension: "json") else {
                throw ServiceError.noDataReceived
            }

            let data = try! Data(contentsOf: fileResource)
            let monsters = try! JSONDecoder().decode([Monster].self, from: data)

            if  let monster1 = monsters.first(where: { $0.id == battleBody.monster1Id }),
                let monster2 =  monsters.first(where: { $0.id == battleBody.monster2Id }) {

                let monster1Sum = monster1.attack + monster1.defense + monster1.hp + monster1.speed
                let monster2Sum = monster2.attack + monster2.defense + monster2.hp + monster2.speed

                if monster1Sum > monster2Sum {
                    let battle = Battle(winner: monster1, tie: false)
                    apiResponse = BattleApiResponse(statusCode: 200, battle: battle)
                }

                if monster2Sum > monster1Sum {
                    let battle = Battle(winner: monster2, tie: false)
                    apiResponse = BattleApiResponse(statusCode: 200, battle: battle)
                }

                if monster1Sum == monster2Sum {
                    let battle = Battle(winner: nil, tie: true)
                    apiResponse = BattleApiResponse(statusCode: 200, battle: battle)
                }

            } else {
                throw ServiceError.invalidId
            }

        } catch {
            apiResponse = BattleApiResponse(statusCode: 500, errorMessage: error.localizedDescription)
        }

        jsonResponse = try! JSONEncoder().encode(apiResponse)
        return String(data: jsonResponse, encoding: .utf8) ?? ""
    }
}
