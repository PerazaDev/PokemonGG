//
//  UIView.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import UIKit
extension UIView {
    static let loadingViewTag = 1938123987
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }

        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
      loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
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
