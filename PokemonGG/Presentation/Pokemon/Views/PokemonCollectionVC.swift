//
//  PokemonCollectionVC.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 19/04/23.
//

import Foundation
import UIKit

protocol PokemonCollectionDelegate: AnyObject{
    func selectEvolution(id: Int)
}

class PokemonCollectionVC: UICollectionView{
    var array:[Pokemon.Evolution] = [] {didSet{
        DispatchQueue.main.async {
            self.reloadData()
        }
    }}
    weak var actions: PokemonCollectionDelegate?
    
}

extension PokemonCollectionVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension PokemonCollectionVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        actions?.selectEvolution(id: array[indexPath.row].id)
    }
}
