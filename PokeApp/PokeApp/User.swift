//
//  User.swift
//  PokeApp
//
//  Created by Damir Kopljar on 7/16/16.
//  Copyright © 2016 Damir Kopljar. All rights reserved.
//

import Foundation

import Unbox

struct User: Unboxable {
    let authToken: String
    let email: String
    let username: String
    
    init(unboxer: Unboxer) {
        authToken = unboxer.unbox("data.attributes.auth-token")
        email = unboxer.unbox("data.attributes.email")
        username = unboxer.unbox("data.attributes.username")
    }
}