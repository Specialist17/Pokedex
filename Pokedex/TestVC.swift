//
//  TestVC.swift
//  Pokedex
//
//  Created by Fernando on 9/14/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let session = URLSession.shared
        let baseURL = URL(string: "http://pokeapi.co/api/v1/pokemon/1/")!
        
        let request = URLRequest(url: baseURL)
        
        session.dataTask(with: request) { (data, resp, err) in
            //    print(data.result.value)
            if let data = data {
                
                guard let pokemon = try? JSONDecoder().decode(PokeStruct.self, from: data)
                    else {return}
                
                print(pokemon.name)
            }
        }.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
