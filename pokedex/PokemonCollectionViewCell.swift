//
//  PokemonCollectionViewCell.swift
//  pokedex
//
//  Created by Caio Alcântara on 26/04/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func updateUI(_ pokemon: Pokemon){
        
        pokeNameLabel.text = pokemon.name.capitalized 
        pokeImage.image = UIImage(named: "\(pokemon.pokedexId)")
    }
    
}
