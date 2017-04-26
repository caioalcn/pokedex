//
//  PokemonViewController.swift
//  pokedex
//
//  Created by Caio Alcântara on 26/04/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        parsePokemonCSV()
        
    }
    
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
     
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                pokemons.append(Pokemon(name: name, pokedexId: pokeId))
                
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
        collectionView.reloadData()
    }
}

extension PokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonCollectionViewCell
        
        cell.updateUI(pokemons[indexPath.row])
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 105, height: 105)
    }
    
    
}
