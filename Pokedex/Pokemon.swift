//
//  Pokemon.swift
//  Pokedex
//
//  Created by Fernando on 6/17/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _attack: String!
    private var _weight: String!
    private var _nextEvoText: String!
    private var _pokemonUrl: String!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }
    
    func donwloadPokemonDetails(completed: DownloadComplete) {
        Alamofire.request(_pokemonUrl).responseJSON { (res) in
            print(res.result.value)
        }
    }
}
