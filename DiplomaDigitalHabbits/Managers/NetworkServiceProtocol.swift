//
//  NetworkServiceProtocol.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 22.11.2021.
//

import Foundation

typealias PriceHandler = Result<TradingModel?, NetworkServiceError>
typealias LogoHandler = Result<LogoModel, NetworkServiceError>

protocol NetworkServiceProtocol {
    func requestWithEndPoint(endPoint: EndPoint, completion: @escaping (PriceHandler) -> Void)
    func process (endPoint: EndPoint, completion: @escaping (LogoHandler) -> Void)
}
