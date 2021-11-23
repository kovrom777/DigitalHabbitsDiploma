//
//  NetworkServiceProtocol.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 22.11.2021.
//

import Foundation

typealias PriceHandler = Result<TradingModel?, NetworkServiceError>

protocol NetworkServiceProtocol {
    func requestPrice (symbol: String, completion: @escaping (PriceHandler) -> Void)
}
