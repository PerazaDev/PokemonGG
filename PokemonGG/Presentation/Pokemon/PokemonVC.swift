//
//  PokemonVC.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import UIKit
import Combine

class PokemonVC: UIViewController {
    private let viewModel = PokemonViewModel()
    private var id: Int = 0
    private var anycancelable:[AnyCancellable] = []
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.text = "aloja \(id)"
        view.addSubview(label)
        return label
    }()
    lazy var evolutions: PokemonCollectionVC = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .init(width: 200, height: 160)
        let collection = PokemonCollectionVC(frame: CGRect(x: 0, y: 0, width: Utils.screenWidth, height: 200), collectionViewLayout: layout)
        collection.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "PokemonCollectionViewCell")
        collection.backgroundColor = .blue
        collection.dataSource =  collection
        collection.delegate = collection
        v2.addSubview(collection)
        return collection
    }()
    lazy var scrollview: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.addSubview(containerVstack)
        return scrollview
    }()
    lazy var containerVstack: UIStackView = {
        let vstack = UIStackView(arrangedSubviews: [])
        vstack.backgroundColor  = .blue
        vstack.axis = .vertical
        vstack.alignment = .fill
        vstack.distribution = .fill
        return vstack
    }()
    lazy var subcontainerVstack: UIStackView = {
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.alignment = .fill
        vstack.distribution = .fill
        return vstack
    }()
    
    lazy var containerView: UIView = {
       let containerView = UIView()
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .redColor
        containerView.addSubview(subcontainerVstack)
        return containerView
    }()
    
    lazy var containerImage: UIView = {
       let containerView = UIView()
        containerView.backgroundColor = .blueColor
        containerView.addSubview(img)
        return containerView
    }()
    lazy var img: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    lazy var v2: UIView = {
       let containerView = UIView()
        containerView.backgroundColor = .red
        return containerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollview)
        configureContrains()
        configureBindings()
        //label.center = view.center
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollview.setColorPokemon(id: id)
        img.setImgPokemon(id: id)
        Task{
            await viewModel.getInfo(id: id)
        }
        
    }
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
    
    private func configureContrains(){
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        containerVstack.translatesAutoresizingMaskIntoConstraints = false
        subcontainerVstack.translatesAutoresizingMaskIntoConstraints = false
        containerImage.translatesAutoresizingMaskIntoConstraints = false
        v2.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        img.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollview.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollview.topAnchor.constraint(equalTo: view.topAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerVstack.widthAnchor.constraint(equalTo: scrollview.widthAnchor, multiplier: 1),
            containerVstack.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
            containerVstack.topAnchor.constraint(equalTo: scrollview.topAnchor),
            containerImage.heightAnchor.constraint(equalToConstant: 300),
            v2.heightAnchor.constraint(equalToConstant: 1000),
            containerVstack.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            img.widthAnchor.constraint(equalToConstant: 100),
            img.heightAnchor.constraint(equalToConstant: 100),
            img.leadingAnchor.constraint(equalTo: containerImage.leadingAnchor, constant: 0),
            img.trailingAnchor.constraint(equalTo: containerImage.trailingAnchor, constant: 0),
            img.bottomAnchor.constraint(equalTo: containerImage.bottomAnchor, constant: 0),
            img.topAnchor.constraint(equalTo: containerImage.topAnchor, constant: 0),
            evolutions.centerXAnchor.constraint(equalTo: v2.centerXAnchor),
            evolutions.topAnchor.constraint(equalTo: v2.topAnchor, constant: 10)
            /*,
            subcontainerVstack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            subcontainerVstack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            subcontainerVstack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            subcontainerVstack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            subcontainerVstack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20)*/
        ])
        containerVstack.addArrangedSubview(containerImage)
        containerVstack.addArrangedSubview(v2)
        
    }
    func configureBindings(){
        viewModel.$error.sink { error in
            if error{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Aviso", message: "Ocurrio un error", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
        .store(in: &anycancelable)
        viewModel.$model.sink {[weak self] pokemon in
            guard let self = self else{return}
            evolutions.array = pokemon.evolutions
            
            DispatchQueue.main.async {
                self.title = pokemon.name
            }
            
        }.store(in: &anycancelable)
    }
    
}
