import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("monsters") { req async -> String in
        return BattleofMonstersServices.getMonsters()
    }

    app.post("battle") { req in

        guard let body = req.body.data else {
            let apiResponse = BattleApiResponse(statusCode: 500, errorMessage: ServiceError.missingId.localizedDescription)
            let jsonResponse = try! JSONEncoder().encode(apiResponse)
            return String(data: jsonResponse, encoding: .utf8) ?? ""
        }

        let battleBody = try JSONDecoder().decode(BattleBody.self, from: body)

        return BattleofMonstersServices.battle(battleBody: battleBody)
    }
}
