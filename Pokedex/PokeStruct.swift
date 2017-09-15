//
//  PokeStruct.swift
//  Pokedex
//
//  Created by Fernando on 9/14/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import Foundation



struct PokeStruct {
    
    let name: String!
    let pokedexId: Int!
    let hp: Int!
    
    
    init(title: String, pokedexId: Int, hp: Int) {
        self.name = title
        self.pokedexId = pokedexId
        self.hp = hp
    }
    
}

struct Results {
    
    let name: String!
    let pokeResource: URL!
    
    
    init(name: String, pokemonResource: URL) {
        self.name = name
        self.pokeResource = pokemonResource
        
    }
    
}

struct Pokedex {
    let count: Int!
    let previous: URL!
    let results: [Results]!
    let next: URL!
    
    init(count: Int, previous: URL, next: URL, results: [Results]) {
        self.count = count
        self.previous = previous
        self.next = next
        self.results = results
    }
}

//extension Pokedex: Decodable {
//    // Declaring our keys
//    enum Keys: String, CodingKey {
//        case count
//        case results
//        case hp
//    }
//    
//    init(from decoder: Decoder) throws {
//        // define our keyed container
//        let container = try decoder.container(keyedBy: Keys.self)
//        
//        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
//        let pokedexId: Int = try container.decode(Int.self, forKey: .pokedexId)
//        let hp: Int = try container.decode(Int.self, forKey: .hp)
//        
//        self.init(title: name, pokedexId: pokedexId, hp: hp)
//    }
//}

extension PokeStruct: Decodable {
    
    // Declaring our keys
    enum Keys: String, CodingKey {
        case name
        case pokedexId = "pkdx_id"
        case hp
    }
    
    init(from decoder: Decoder) throws {
        // define our keyed container
        let container = try decoder.container(keyedBy: Keys.self)
        
        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
        let pokedexId: Int = try container.decode(Int.self, forKey: .pokedexId)
        let hp: Int = try container.decode(Int.self, forKey: .hp)
        
        self.init(title: name, pokedexId: pokedexId, hp: hp)
    }
}
