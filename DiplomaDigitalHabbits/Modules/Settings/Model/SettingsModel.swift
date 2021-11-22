//
//  SettingsModel.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 22.11.2021.
//

import Foundation

class SettingsModel {
    // MARK: - Variables
    static let shared = SettingsModel()
    var useWebSocket = false
    // MARK: - Init
    private init () {}
}
