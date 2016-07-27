//
//  File.swift
//  PokeApp
//
//  Created by Damir Kopljar on 7/16/16.
//  Copyright © 2016 Damir Kopljar. All rights reserved.
//

import Foundation
import Unbox

struct PokemonResponse: Unboxable {
    let pokemons: [Pokemon]
    
    init(unboxer: Unboxer) {
        pokemons = unboxer.unbox("data")
    }
}

struct Pokemon: Unboxable {
    let name: String
    
    init(unboxer: Unboxer) {
        name = unboxer.unbox("attributes.name")
    }
}

