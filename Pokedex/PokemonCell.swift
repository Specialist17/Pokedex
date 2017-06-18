//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Fernando on 6/17/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        imgThumb.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
