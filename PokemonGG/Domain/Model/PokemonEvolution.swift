//
//  PokemonEvolution.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 19/04/23.
//

import Foundation

struct PokemonEvolutionAPIModel: Codable {
    var chain: Chain?
    var id: Int?

    struct Chain: Codable {
        var evolution_details: [EvolutionDetail]?
        var evolves_to: [Chain]?
        var is_baby: Bool?
        var species: Species?

    }
    struct EvolutionDetail: Codable {
        var min_level: Int?

    }
    struct Species: Codable {
        var name: String
        var url: String
        var id: Int{
            return url.idURL
        }
    }

}

