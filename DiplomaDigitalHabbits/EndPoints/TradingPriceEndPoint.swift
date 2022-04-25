//
//  TradingPriceEndPoint.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 08.12.2021.
//

import Foundation

class TradingPriceEndPoint: EndPoint {
    var components: URLComponents = URLComponents(string: Constants.StockRequest.baseURL + "/time_series")!
    var method: String = "GET"
    
    init(symbol: String, key: String) {
        components.queryItems = [
            URLQueryItem(name: "symbol", value: symbol.replacingOccurrences(of: " ", with: "")),
            URLQueryItem(name: "interval", value: "5min"),
            URLQueryItem(name: "apikey", value: key)
        ]
    }
}
