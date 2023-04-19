//
//  PokemonSpecies.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import UIKit

struct SpeciesAPIModel: Codable{
    var color: Color
    var name: String
    var evolution_chain: EvolutionChain
    struct Color: Codable {
        var name: Colors
    }
    struct EvolutionChain: Codable{
        var url: String
        var id: Int{
            return url.idURL
        }
    }
}

enum Colors:String, Codable{
    case black
    case blue
    case brown
    case gray
    case green
    case pink
    case purple
    case red
    case white
    case yellow
    
    var color: UIColor{
        switch self {
        case .black:
            return .black
        case .blue:
            return .blueColor
        case .brown:
            return .brown
        case .gray:
            return .gray
        case .green:
            return .greenColor
        case .pink:
            return .pinkColor
        case .purple:
            return .systemIndigo
        case .red:
            return .redColor
        case .white:
            return .whiteColor
        case .yellow:
            return .yellow
            
        }
    }
    
}
