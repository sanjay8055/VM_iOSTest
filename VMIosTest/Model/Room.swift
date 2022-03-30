//
//  Room.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import Foundation

struct Room: Decodable {
    let id: String
    let isOccupied: Bool
    let maxOccupancy: Int
}
