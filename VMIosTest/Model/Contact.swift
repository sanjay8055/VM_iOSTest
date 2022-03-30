//
//  Contact.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import Foundation

struct Contact: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let avatar: String
    let jobtitle: String
    let favouriteColor: String
}
