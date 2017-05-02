//
//  Pokemon.swift
//  pokedex
//
//  Created by Caio Alcântara on 26/04/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name = ""
    private var _pokedexId = 0
    private var _descriptions = ""
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
    
    var descriptions: String {
        return _descriptions
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
    
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    func donwloadPokemonDetail(completed: @escaping DownloadComplete ) {
        
        Alamofire.request(_pokemonURL, method: .get).responseJSON { response in
             
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0{
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"]{
                                
                                self._type += "/\(name.capitalized)"
                                
                            }
                        }
                    }
                    
                    
                } else {
                    
                    self._type = ""
                 }
                
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        
                        let descURL = "\(URL_BASE)\(url)"

                        Alamofire.request(descURL, method: .get).responseJSON { response in
                        
                            if let descDict = response.result.value as? Dictionary<String, AnyObject>{
                                
                                if let descriptions = descDict["description"] as? String {
                                    
                                    let newDescription = descriptions.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._descriptions = newDescription
                                }
                            }
                            completed()

                        }

                    } else {
                        
                        self._descriptions = ""
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                        
                        if let nextEvo = evolutions[0]["to"] as? String {
                            
                            if nextEvo.range(of: "mega") == nil {
                                
                                self._nextEvolutionName = nextEvo
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    
                                    let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                                    
                                    self._nextEvolutionId = nextEvoId
                                    
                                    if let lvlExits = evolutions[0]["level"] {
                                        
                                        if let lvl = lvlExits as? Int {
                                            
                                            self._nextEvolutionLevel = "\(lvl)"
                                        }
                                    } else {
                                        
                                        self._nextEvolutionLevel = ""
                                    }
    
                                }
                                
                                
                            }
 
                        }
                    }
                    
                }
                completed()

            }
    
        }
    }
    
}
