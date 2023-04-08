//
//  String.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import Foundation

extension String{
    var idURL: Int{
        let regex = try! NSRegularExpression(pattern: "/(\\d+)/") // Expresión regular que coincide con un número entero entre barras diagonales
        let match = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        if let range = Range(match!.range(at: 1), in: self) {
            let intStr = self[range]
            return Int(intStr) ?? -1
        }
        return -1
    }
}
