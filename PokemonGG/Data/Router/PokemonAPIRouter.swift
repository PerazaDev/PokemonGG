//
//  PokemonAPIRouter.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 05/04/23.
//

import Foundation

enum PokemonAPIRouter: APIConfiguration{
    case pokemonEvolutions(id: Int)
    case pokemonImg(id: Int)
    case pokemonSpecies(id: Int)
    
    var method: MethodRequest{
        switch self {
        default:
            return .GET
        }
    }
    
    var path: String{
        switch self {
        case .pokemonEvolutions(let id):
            return "https://pokeapi.co/api/v2/evolution-chain/\(id)"
        case .pokemonImg(let id):
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        case .pokemonSpecies(let id):
            return "https://pokeapi.co/api/v2/pokemon-species/\(id)"
        }
    }
    
    var parameters: [String : Any]?{
        return nil
    }
    
    var jsonDecoder: JSONDecoder{
        return JSONDecoder()
    }
    
    var urlRequest: URLRequest{
        
        var urlRequest = URLRequest(url: URL(string: path)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters!,options: .prettyPrinted)
        return urlRequest
    }
    
    
}
