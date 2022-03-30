//
//  AppTheme.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import Foundation

struct Config: Decodable {
    let primaryColor: String
}

class AppTheme {
    static let shared = AppTheme().loadAppTheme()
    private init() {}
    func loadAppTheme() -> Config? {
        if let path = Bundle.main.url(forResource: "AppTheme", withExtension: "plist"), let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            return try! decoder.decode(Config.self, from: data)
        }
        return nil
    }
}
