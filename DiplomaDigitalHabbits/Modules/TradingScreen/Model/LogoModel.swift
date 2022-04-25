//
//  LogoModel.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 08.12.2021.
//

import Foundation

class LogoModel {
    let symbol: String?
    let url: String?
    var data: Data?
    
    init(from dict: [String: Any]) {
        let meta = dict["meta"] as? [String: Any]
        self.symbol = meta?["symbol"] as? String
        self.url = dict["url"] as? String
    }
}
