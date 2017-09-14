//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Fernando on 6/18/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    let loading = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        nameLbl.text = pokemon.name
//
//        let img = UIImage(named: "\(pokemon.pokedexId)")
//        mainImg.image = img
//        currentEvoImg.image = img
//        nextEvoImg.image = UIImage(named: "\(pokemon.pokedexId + 1)")
//
//        pokemon.donwloadPokemonDetails {
//            // Called after the network call is complete
//
//            self.updateUi()
//            self.loading.stopAnimating()
//        }
//
//        pokemon.todoByID(2) { (poke, error) in
//            print(poke?.name ?? "no hay na")
//        }
    }
    
    
    func updateUi() {
//        baseAttackLbl.text = pokemon.attack
//        defenseLbl.text = pokemon.defense
//        heightLbl.text = pokemon.height
//        weightLbl.text = pokemon.weight
//        typeLbl.text = pokemon.type
//        pokedexIdLbl.text = "\(pokemon.pokedexId)"
//        descriptionLbl.text = pokemon.description
//
//        if pokemon.nextEvoId == "" {
//            evoLbl.text = "No Evolutions"
//            nextEvoImg.isHidden = true
//        } else {
//            nextEvoImg.isHidden = false
//            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvoId)")
//
//            let nextStr = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLvl)"
//            evoLbl.text = nextStr
//        }
        
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
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
