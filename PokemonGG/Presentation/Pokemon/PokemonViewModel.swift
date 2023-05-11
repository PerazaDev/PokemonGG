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
        model.append(Pokemon.Evolution(name: evolutions.chain?.species?.name ?? "",
                                       id: evolutions.chain?.species?.id ?? 0,
                                       minLevel: evolutions.chain?.evolution_details?.first?.min_level ?? 0))
        let all = mapChain(chain: evolutions.chain?.evolves_to ?? [])
        model.append(contentsOf: all.map({Pokemon.Evolution(name: $0.species?.name ?? "",
                                                            id: $0.species?.id ?? 0,
                                                            minLevel: $0.evolution_details?.first?.min_level ?? 0)}))
        return model
    }
    private func mapChain(chain:  [PokemonEvolutionAPIModel.Chain]) -> [PokemonEvolutionAPIModel.Chain]{
        return chain + chain.compactMap { $0.evolves_to}.flatMap(mapChain)

    }
}
