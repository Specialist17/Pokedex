//
//  ViewController.swift
//  Pokedex
//
//  Created by Fernando on 6/17/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var pokeCollection: UICollectionView!
    @IBOutlet weak var sliderBar: UISlider!
    
//    var pokemon: PokeStruct
    var pokemonArr = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var pokeStructArr = [PokeStruct]()
    var filteredPokeStruct = [PokeStruct]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeCollection.dataSource = self
        pokeCollection.delegate = self
        pokeSearchBar.delegate = self
        
        pokeSearchBar.returnKeyType = UIReturnKeyType.done
        
        PokemonService.getPokemon { (poke) in
            
            guard let pokemon = poke else {return}
            print(pokemon)
        }
        
        parsePokemonCSV()
        initAudio()
    }
    
    //Audio
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //Parse CSV
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon = Pokemon(name: name, pokedexId: pokeId)
                pokemonArr.append(pokemon)
                
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //Collection View
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokemonCell {
            let poke: Pokemon!
            if inSearchMode {
                
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            } else {
                
                poke = pokemonArr[indexPath.row]
                cell.configureCell(poke)
            }
            
            return cell
        
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemonArr[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokeDetailVC", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemonArr.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
    //Search Bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            view.endEditing(true)
            pokeCollection.reloadData()
            
            
        } else {
            
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemonArr.filter({ $0.name.range(of: lower) != nil })
            pokeCollection.reloadData()
            
        }
    }
    
    
    //Music Button
    @IBAction func musicButtonWasPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.3
            sliderBar.isHidden = true
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
            sliderBar.isHidden = false
        }
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        let volumeVal = Float(sender.value)
        musicPlayer.volume = volumeVal
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokeDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    
}

