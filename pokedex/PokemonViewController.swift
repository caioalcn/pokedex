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
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
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
        
        if inSearchMode{
            
            return filteredPokemon.count
            
        } else {
            
            return pokemons.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonCollectionViewCell
        
        if inSearchMode{
            
            cell.updateUI(filteredPokemon[indexPath.row])
            
        } else {
            
            cell.updateUI(pokemons[indexPath.row])
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 105, height: 105)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPokemon" {
            if let detailvc = segue.destination as? DetailPokemonViewController {
                if let indexPath = collectionView.indexPath(for: sender as! PokemonCollectionViewCell) {
                    if inSearchMode{
                        
                        detailvc.pokemon = filteredPokemon[indexPath.row]
                        
                    } else {
                        
                        detailvc.pokemon = pokemons[indexPath.row]
                         
                    }
                }
            }
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemons.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
}
