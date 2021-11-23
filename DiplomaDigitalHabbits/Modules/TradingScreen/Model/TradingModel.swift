//
//  TradingModel.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 27.10.2021.
//

import Foundation

struct TradingModel: Decodable {
    let meta: Meta?
    let values: [Value]?
    let status: String
    
    enum Keys: String, CodingKey {
        case meta = "meta"
        case values = "values"
        case status = "status"
    }
}

struct Meta: Decodable {
    let symbol: String
    let interval: String
//    let currency: String
//    let exchangeTimezone: String
    let exchange: String
    let type: String
    
    
}

struct Value: Decodable {
    let datetime: String
    let open: String
    let high: String
    let low: String
    let close: String
//    let volume: String

//    enum Keys: String, CodingKey {
//        case datetime = "datetime"
//        case open = "open"
//        case high = "high"
//        case low = "low"
//        case close = "close"
//        case volume = "volume"
//    }
}
