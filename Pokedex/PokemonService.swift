//
//  PokemonService.swift
//  Pokedex
//
//  Created by Fernando on 9/14/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import Foundation
import UIKit

struct PokemonService {
    static func getPokemon(completion: @escaping (PokeStruct?) -> Void){
        let session = URLSession.shared
        let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!
        
        let request = URLRequest(url: baseURL)

        session.dataTask(with: request) { (data, resp, err) in
            //    print(data.result.value)
            if let data = data {
                
                guard let poke = try? JSONDecoder().decode(PokeStruct.self, from: data)
                    else {return}
                
                print(poke.name)
                completion(poke)
            }
        }.resume()
        
        
    }
}
