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
            
        }catch{
            self.error = true
        }
    }
}
