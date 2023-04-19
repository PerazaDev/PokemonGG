//
//  PokemonViewModel.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 19/04/23.
//

import Foundation

class PokemonViewModel{
    private var useCase: PokemonUseCaseProtocol = PokemonUseCase(services: PokemonServices())
}
