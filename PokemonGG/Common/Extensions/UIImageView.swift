//
//  UIImage.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import UIKit
import Combine
extension UIImageView{
    
    func downloadImage(id: Int) {
        guard let url = URL(string: PokemonAPIRouter.pokemonImg(id: id).path) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
                
            }
        }
        
    }
    func setImgPokemon(id: Int){
        self.showLoading()
        guard let url = URL(string: PokemonAPIRouter.pokemonImg(id: id).path) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async { [self] in
                    image = loadedImage
                    self.stopLoading()
                }
            }
            
        }.resume()
    }
    func setColorPokemon(id: Int){
        guard let url = URL(string: PokemonAPIRouter.pokemonSpecies(id: id).path) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let dataSpecie = data, let model = try? JSONDecoder().decode(SpeciesAPIModel.self, from: dataSpecie){
                DispatchQueue.main.async { [self] in
                    self.backgroundColor = model.color.name.color
                }
            }
        }.resume()
    }
}

