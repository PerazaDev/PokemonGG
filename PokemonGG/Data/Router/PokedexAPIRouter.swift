//
//  PokedexAPIRouter.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 05/04/23.
//

import Foundation
enum PokedexAPIRouter: APIConfiguration{
    case pokedex(id: Int)
    case podexes
    var method: MethodRequest{
        switch self {
        default:
            return .GET
        }
    }
    
    var path: String{
        switch self {
        case .pokedex(let id):
            return "https://pokeapi.co/api/v2/pokedex/\(id)/"
        case .podexes:
            return "https://pokeapi.co/api/v2/pokedex"
        }
    }
    
    var parameters: [String : Any]?{
        switch self {
        default:
         return nil
        }
    }
    
    var jsonDecoder: JSONDecoder{
        return JSONDecoder()
    }
    
    var urlRequest: URLRequest{
        
        var urlRequest = URLRequest(url: URL(string: path)!)
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters{
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters,options: .prettyPrinted)
        }
        return urlRequest
    }
    
    
}
