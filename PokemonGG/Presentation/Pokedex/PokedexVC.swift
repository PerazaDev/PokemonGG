//
//  PokedexVC.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 05/04/23.
//

import UIKit
import Combine

class PokedexVC: UIViewController {
    private var viewModel: PokedexViewModel = .init()
    private var anycancelable:[AnyCancellable] = []
   private var index = -1
   
    lazy var pokedexTV: PokedexTableVC = {
        let  tb = PokedexTableVC(frame: view.bounds, style: .insetGrouped)
        tb.register(PokedexCell.self, forCellReuseIdentifier: PokedexCell.identifier)
        tb.delegateActions = self
        tb.dataSource = tb
        tb.delegate = tb
        view.addSubview(tb)
        return tb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindings()
        fetch()
    }
    
    private func fetch(){
        Task{
            await viewModel.getPokedexes()
            if !self.viewModel.pokedexes.isEmpty{
                self.index = viewModel.pokedexes.first?.id ?? -1
                await self.viewModel.getPokedex(id:viewModel.pokedexes.first?.id ?? -1)
                menuhandler()
            }
        }
    }
    private func menuhandler(){
        let menu = UIMenu(title: "Regions", children:viewModel.pokedexes.map({ pokedex in
            UIAction(title: pokedex.name,state: index == pokedex.id ? .on : .off, handler: { _ in
                Task{
                    self.index = pokedex.id
                    self.menuhandler()
                    await self.viewModel.getPokedex(id:pokedex.id)
                }
               })
        }))
        let menuButton = UIBarButtonItem(title: (viewModel.pokedexes.first(where: {$0.id == index})?.name) ?? "Select", menu: menu)
        self.navigationItem.rightBarButtonItem = menuButton
    }
    private func bindings(){
        viewModel.$error.sink { error in
            if error{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Aviso", message: "Ocurrio un error", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }.store(in: &anycancelable)
        
        viewModel.$pokedex.sink {[weak self] pokedex in
            guard let self = self else{return}
            pokedexTV.array = pokedex.pokemon_entries.sorted(by: {$0.pokemon_species.name < $1.pokemon_species.name})
            
        }
        .store(in: &anycancelable)
    }
    private func configureView(){
        view.backgroundColor = .blue
        pokedexTV.center = view.center
       

    }
}
extension PokedexVC: ActionsPokedexTableVC{
    func selectRow(id: Int) {
        let vc = PokemonVC(id: id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
