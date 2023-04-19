//
//  PokedexServices.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import Foundation

protocol PokedexServicesProtocol: AnyObject{
    func getPokedex(id: Int) async throws -> PokedexAPIModel
    func getPokedexes() async throws -> PokedexesAPIModel
    
}
class PokedexServices:PokedexServicesProtocol{
    
    func getPokedex(id: Int) async throws -> PokedexAPIModel{
        return try await APIManager.shared.request(api: PokedexAPIRouter.pokedex(id: id))
    }
    
    func getPokedexes() async throws -> PokedexesAPIModel{
        return try await APIManager.shared.request(api: PokedexAPIRouter.podexes)
    }
    
}
