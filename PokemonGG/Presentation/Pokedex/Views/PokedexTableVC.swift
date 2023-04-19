//
//  PokedexTableVC.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 05/04/23.
//

import UIKit
protocol ActionsPokedexTableVC: AnyObject{
    func selectRow(id:Int)
}


class PokedexTableVC: UITableView {
    weak var delegateActions: ActionsPokedexTableVC?
    var array: [PokedexAPIModel.PokemonEntries] = [] {didSet{
        DispatchQueue.main.async {
            self.reloadData()
        }
    }}
}

extension PokedexTableVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokedexCell.identifier, for: indexPath) as? PokedexCell else {return UITableViewCell()}
        cell.configure(pokemon: array[indexPath.row].pokemon_species)
        return cell
    }
    
    
}
extension PokedexTableVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegateActions?.selectRow(id: array[indexPath.row].pokemon_species.id)
        
    }
    
}
