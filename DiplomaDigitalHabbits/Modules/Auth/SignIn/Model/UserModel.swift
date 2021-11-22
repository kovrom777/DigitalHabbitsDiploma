//
//  UserModel.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//

import Foundation

class UserModel: Decodable, Encodable {
    let login: String
    let password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
