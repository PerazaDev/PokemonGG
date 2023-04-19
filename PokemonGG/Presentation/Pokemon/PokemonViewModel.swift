//
//  PokemonViewModel.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 19/04/23.
//

import Foundation

class PokemonViewModel{
    private var useCase: PokemonUseCaseProtocol = PokemonUseCase(services: PokemonServices())
    @Published var model: Pokemon = .empty
    @Published var error: Bool = false
    
    
    func getInfo(id: Int) async{
        do{
            let species = try await useCase.getSpecies(id: id)
            let evolution = try await useCase.getEvolutions(id: species.evolution_chain.id)
            let evolutionsMapped = mapper(evolutions: evolution)
            model = .init(name: species.name, evolutions: evolutionsMapped)
        }catch{
            self.error = true
        }
    }
    
    private func mapper(evolutions: PokemonEvolutionAPIModel) ->[Pokemon.Evolution]{
        var model : [Pokemon.Evolution] = []
        for index in 1...30 {
            model.append(Pokemon.Evolution(name: "aloja \(index)", id: 0, minLevel: 0))
        }
        return model
    }
}
