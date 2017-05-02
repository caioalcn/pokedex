//
//  Pokemon.swift
//  pokedex
//
//  Created by Caio Alcântara on 26/04/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit

class Pokemon {
    
    private var _name = ""
    private var _pokedexId = 0
    private var _description = ""
    private var _type = ""
    private var _defense = ""
    private var _height = ""
    private var _weight = ""
    private var _attack = ""
    private var _nextEvolutionTxt = ""
    private var _nextEvolutionName = ""
    private var _nextEvolutionId = ""
    private var _nextEvolutionLevel = ""
    private var _pokemonURL = ""
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        return _description
    }
    
    var type: String {
        return _type
    }
    
    var defense: String {
        return _defense
    }
    
    var height: String {
        return _height
    }
    
    var weight: String {
        return _weight
    }
    
    var attack: String {
        return _attack
    }
    
    var nextEvolutionTxt: String {
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String {
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        return _nextEvolutionLevel
    }
    
    var pokemonURL: String {
        return _pokemonURL
    }
    
    
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        
        
    }
}
