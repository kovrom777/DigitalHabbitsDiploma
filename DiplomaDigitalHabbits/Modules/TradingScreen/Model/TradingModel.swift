//
//  TradingModel.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 27.10.2021.
//

import Foundation

struct TradingModel: Decodable{
    
    let meta: Meta
    let values: [Value]
    let status: String
    
}

struct Meta: Decodable {
    let symbol: String
    let interval: String
    let currency: String
    let exchangeTimezone: String
    let exchange: String
    let type: String
    
    enum Keys: CodingKey {
        case symbol
        case interval
        case currency
        case exchangeTimezone
        case exchange
        case type
    }
}

struct Value: Decodable {
    let datetime: String
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
}
