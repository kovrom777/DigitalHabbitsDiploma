//
//  LogoEndPoint.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 08.12.2021.
//

import Foundation

class LogoEndPoint: EndPoint{
    var method: String = "GET"
    
    var components: URLComponents = URLComponents(string: Constants.StockRequest.baseURL + "/logo")!
    
    init(symbol: String, key: String) {
        components.queryItems = [
            URLQueryItem(name: "symbol", value: symbol.replacingOccurrences(of: " ", with: "")),
            URLQueryItem(name: "interval", value: "5min"),
            URLQueryItem(name: "apikey", value: "e4e382a154f846648a9c8c327aa703a6")
        ]
    }
    
    
}
