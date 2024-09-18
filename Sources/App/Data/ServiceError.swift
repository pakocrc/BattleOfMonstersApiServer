//
//  ServiceError.swift
//
//
//  Created by Francisco Cordoba on 17/9/24.
//

import Foundation

enum ServiceError: String, Error, Codable {
    case noDataReceived = "Data was not retrieved from request"
    case decodingError = "Error decoding the response"
    case missingId = "Battle - Missing ID"
    case invalidId = "Battle - Invalid ID"
    case unexpectedError = "Unexpected error"
    case noRequestBody = "No request body found"
}
