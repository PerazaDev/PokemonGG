//
//  PokemonCollectionViewCell.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 19/04/23.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    lazy var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment =   .center
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(img)
        return view
    }()
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    lazy var img: UIImageView = {
        let view = UIImageView()
        view.scalesLargeContentImage = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)

        stack.translatesAutoresizingMaskIntoConstraints = false
        img.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            img.widthAnchor.constraint(equalToConstant: 150),
            img.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(evolution:Pokemon.Evolution){
        titleLabel.text = evolution.name
        img.setImgPokemon(id: evolution.id)
    }

}
