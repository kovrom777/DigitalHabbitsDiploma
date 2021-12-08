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
    var image: Data? = nil
    
    enum Keys: String, CodingKey {
        case meta = "meta"
        case values = "values"
        case status = "status"
    }
}

struct Meta: Decodable {
    let symbol: String
    let interval: String
    let exchange: String
    let type: String
    
    
}

struct Value: Decodable {
    let datetime: String
    let open: String
    let high: String
    let low: String
    let close: String
}
