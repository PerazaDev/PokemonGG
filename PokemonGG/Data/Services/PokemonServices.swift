//
//  PokemonServices.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 19/04/23.
//

import Foundation
protocol PokemonServicesProtocol: AnyObject{
    func getSpecies(id: Int) async throws -> SpeciesAPIModel
    func getEvolutions(id: Int) async throws -> PokemonEvolutionAPIModel
    
}

 
class PokemonServices: PokemonServicesProtocol{
    func getSpecies(id: Int) async throws -> SpeciesAPIModel {
        return try await APIManager.shared.request(api: PokemonAPIRouter.pokemonSpecies(id: id))
    }
    
    func getEvolutions(id: Int) async throws -> PokemonEvolutionAPIModel {
        return try await APIManager.shared.request(api: PokemonAPIRouter.pokemonEvolutions(id: id))
    }
    
    
}
