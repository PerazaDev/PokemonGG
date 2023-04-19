//
//  Pokemon.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 19/04/23.
//

import Foundation
struct Pokemon{
    var name: String
    var evolutions:[Evolution]
    
    struct Evolution{
        var name: String
        var id: Int
        var minLevel: Int
    }
}
