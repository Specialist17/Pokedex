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
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        
        return _attack
    }
    
    var nextEvoText: String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        
        return _nextEvoText
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }
    
    func donwloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonUrl).responseJSON { (res) in
            guard let dict = res.result.value as? Dictionary<String, AnyObject>,
                let weight = dict["weight"] as? String,
                let height = dict["height"] as? String,
                let attack = dict["attack"] as? Int,
                
                let defense = dict["defense"] as? Int
                else {return}
            
            self._attack = "\(attack)"
            self._weight = weight
            self._defense = "\(defense)"
            self._height = height
            
            print(self._attack)
            print(self._defense)
            print(self._weight)
            print(self._height)
            
            
            if let types = dict["types"] as? [Dictionary<String,String>], types.count > 0{
                if let name = types[0]["name"] {
                    self._type = name.capitalized
                }
                
                if types.count > 1 {
                    for x in 1..<types.count {
                        guard let name = types[x]["name"] else{return}
                        print(name)
                        self._type! += "/\(name.capitalized)"
                    }
                }
            } else {
                self._type = ""
            }
            
            
            completed()
        }
        
        
    }
}
