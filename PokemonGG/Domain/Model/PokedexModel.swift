//
//  PokedexModel.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import Foundation
import UIKit

struct PokedexAPIModel: Codable{
    let name: String
    let pokemon_entries:[PokemonEntries]
    
    struct PokemonEntries: Codable{
        let pokemon_species: PokemonSpecies
        
        struct PokemonSpecies: Codable{
            let name: String
            let url: String
            var id: Int{
                url.idURL
            }
        }
    }
}
struct PokedexesAPIModel: Codable{
    let results: [Result]
    
    
    struct Result:Codable{
        let name: String
        let url: String
        var id: Int{
            url.idURL
        }
    }
}


