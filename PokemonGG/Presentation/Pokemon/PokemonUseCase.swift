//
//  PokemonUseCase.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 19/04/23.
//

import Foundation

protocol PokemonUseCaseProtocol: AnyObject{
    func getSpecies(id: Int) async throws -> SpeciesAPIModel
    func getEvolutions(id: Int) async throws -> PokemonEvolutionAPIModel
}
class PokemonUseCase: PokemonUseCaseProtocol{
    private var services: PokemonServicesProtocol
    init(services: PokemonServicesProtocol) {
        self.services = services
    }
    func getSpecies(id: Int) async throws -> SpeciesAPIModel {
        return try await services.getSpecies(id: id)
    }
    
    func getEvolutions(id: Int) async throws -> PokemonEvolutionAPIModel {
        return try await services.getEvolutions(id: id)
    }
    
    
}
