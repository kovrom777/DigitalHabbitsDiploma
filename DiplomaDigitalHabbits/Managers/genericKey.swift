//
//  genericKey.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 08.12.2021.
//

import Foundation

struct GenericKey {
    let key: String
}

extension GenericKey: SecureStoreQueryable {

    var query: [String : Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = key
        query[String(kSecUseAuthenticationUI)] = false
        query[String(kSecAttrAccessible)] = kSecAttrAccessibleAfterFirstUnlock
        return query
    }
}
