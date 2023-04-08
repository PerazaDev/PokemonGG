//
//  PokedexUseCase.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import Foundation
protocol PokedexUseCaseProtocol: AnyObject{
    func getPokedex(id: Int) async throws -> PokedexAPIModel
    func getPokedexes() async throws -> PokedexesAPIModel
    
}

class PokedexUseCase: PokedexUseCaseProtocol{
    private let services: PokedexServicesProtocol
    init(services: PokedexServicesProtocol) {
        self.services = services
    }
    
    func getPokedex(id: Int) async throws -> PokedexAPIModel {
        return try await services.getPokedex(id: id)
    }
    
    func getPokedexes() async throws -> PokedexesAPIModel {
        return try await services.getPokedexes()
    }
    
    
}
