//
//  PokedexCell.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 05/04/23.
//

import UIKit

class PokedexCell: UITableViewCell {
    static let identifier = "PokedexCell"
    
    lazy var hstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        
        stack.distribution = .fill
        
        stack.addArrangedSubview(imgContainer)
        stack.addArrangedSubview(myLabel)
        return stack
    }()
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    lazy var imgContainer: UIView = {
        let container = UIView()
        container.addSubview(img)
        return container
    }()
    
    
    lazy var img: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 10
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    private func setup(){
        self.contentView.addSubview(hstack)
        self.accessoryType = .disclosureIndicator
        configureConstrainst()
    }
    func configureConstrainst(){
        hstack.translatesAutoresizingMaskIntoConstraints = false
        img.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalToConstant: 50),
            img.heightAnchor.constraint(equalToConstant: 50),
            img.leadingAnchor.constraint(equalTo: imgContainer.leadingAnchor, constant: 0),
            img.trailingAnchor.constraint(equalTo: imgContainer.trailingAnchor, constant: 0),
            img.topAnchor.constraint(equalTo: imgContainer.topAnchor, constant: 0),
            img.bottomAnchor.constraint(equalTo: imgContainer.bottomAnchor, constant: 0),
            
            hstack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            hstack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            hstack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            hstack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    func configure(pokemon: PokedexAPIModel.PokemonEntries.PokemonSpecies){
        myLabel.text  = pokemon.name
        img.setImgPokemon(id: pokemon.id)
        img.setColorPokemon(id: pokemon.id)
    }

}
