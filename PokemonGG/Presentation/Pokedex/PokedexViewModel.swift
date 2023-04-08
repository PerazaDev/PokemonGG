//
//  PokedexViewModel.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import Foundation

class PokedexViewModel{
    private var useCase: PokedexUseCaseProtocol = PokedexUseCase(services: PokedexServices())
    @Published var pokedexes: [PokedexesAPIModel.Result] = []
    @Published var pokedex: PokedexAPIModel = .init(name: "", pokemon_entries: [])
    @Published var error: Bool = false
    func getPokedex(id: Int) async{
        do{
            pokedex = try await useCase.getPokedex(id: id)
        }catch{
            self.error = true
        }
    }
    func getPokedexes() async{
        do{
            let response = try  await useCase.getPokedexes()
            pokedexes = response.results
        }catch{
            self.error = true
        }
    }
    
}
