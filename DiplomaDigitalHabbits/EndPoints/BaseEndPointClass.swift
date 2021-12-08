//
//  BaseEndPointClass.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 22.11.2021.
//

import Foundation

protocol EndPoint {
    var method: String { get }
    var components: URLComponents { get }
}

enum Constants {
    enum StockRequest {
        static let baseURL = "https://api.twelvedata.com"
    }
}
