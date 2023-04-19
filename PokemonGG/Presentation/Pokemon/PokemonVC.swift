//
//  PokemonVC.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 07/04/23.
//

import UIKit

class PokemonVC: UIViewController {
    
    private var id: Int = 0
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.text = "aloja \(id)"
        view.addSubview(label)
        return label
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
    
    lazy var v1: UIView = {
       let containerView = UIView()
        containerView.backgroundColor = .greenColor
        return containerView
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
        //label.center = view.center
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollview.setColorPokemon(id: id)
    }
    private func configureContrains(){
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        containerVstack.translatesAutoresizingMaskIntoConstraints = false
        subcontainerVstack.translatesAutoresizingMaskIntoConstraints = false
        v1.translatesAutoresizingMaskIntoConstraints = false
        v2.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollview.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollview.topAnchor.constraint(equalTo: view.topAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerVstack.widthAnchor.constraint(equalTo: scrollview.widthAnchor, multiplier: 1),
            containerVstack.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
            containerVstack.topAnchor.constraint(equalTo: scrollview.topAnchor),
            v1.heightAnchor.constraint(equalToConstant: 200),
            v2.heightAnchor.constraint(equalToConstant: 1000),
            containerVstack.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor)/*,
            subcontainerVstack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            subcontainerVstack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            subcontainerVstack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            subcontainerVstack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            subcontainerVstack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20)*/
        ])
        containerVstack.addArrangedSubview(v1)
        containerVstack.addArrangedSubview(v2)
        
    }
    
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
}
