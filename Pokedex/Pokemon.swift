//
//  Pokemon.swift
//  Pokedex
//
//  Created by Fernando on 6/17/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit
import Alamofire

class Pokemon: Decodable {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _attack: String!
    private var _weight: String!
    private var _nextEvoText: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
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
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        
        return _nextEvoName
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        
        return _nextEvoId
    }
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        
        return _nextEvoLvl
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
            
            if let descArr = dict["descriptions"] as? [Dictionary<String,String>], descArr.count > 0 {
                if let url = descArr[0]["resource_uri"] {
                    let descUrl = "\(URL_BASE)\(url)"
                    
                    Alamofire.request(descUrl).responseJSON(completionHandler: { (res) in
                        guard let descDict = res.result.value as? Dictionary<String, AnyObject>,
                            let description = descDict["description"] as? String
                            else {return}
                        
                        let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                        
                        self._description = newDescription
                        
                        completed()
                    })
                }
                
            } else {
                self._description = ""
            }
            
            if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>], evolutions.count > 0 {
                guard let nextEvo = evolutions[0]["to"] as? String else{return}
                
                if nextEvo.range(of: "mega") == nil {
                    self._nextEvoName = nextEvo
                    
                    guard let uri = evolutions[0]["resource_uri"] as? String,
                        let lvlExists = evolutions[0]["level"],
                        let lvl = lvlExists as? Int
                        else {
                            self._nextEvoLvl = ""
                            return
                        }
                    
                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon", with: "")
                    let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                    
                    self._nextEvoId = nextEvoId
                    self._nextEvoLvl = "\(lvl)"
                    
                }
            }
            completed()
        }
    }
    
    
    func todoByID(_ id: Int, completionHandler: @escaping (Pokemon?, Error?) -> Void) {
        
        let url = URL(string: "\(URL_BASE)\(URL_POKEMON)\(1)")!
        
        // Make request
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                print("Error: did not receive data")
                
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: responseData)
                completionHandler(pokemon, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
}

