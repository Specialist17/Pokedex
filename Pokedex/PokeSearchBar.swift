//
//  PokeSearchBar.swift
//  Pokedex
//
//  Created by Fernando on 6/18/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class PokeSearchBar: UISearchBar {
    
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        
        searchBarStyle = UISearchBarStyle.prominent
        isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.borderColor = ((UIColor(red: 255/255, green: 214/255, blue: 0/255, alpha: 1.0)).cgColor);
        layer.borderWidth = 1
    }
    
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let pokeSearchBar = subviews[0]
        
        for i in 0 ..< pokeSearchBar.subviews.count {
            if pokeSearchBar.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        
        return index
    }
    
    override func draw(_ rect: CGRect) {
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
            // Access the search field
            let searchField: UITextField = (subviews[0]).subviews[index] as! UITextField
            
            // Set the font and text color of the search field.
            searchField.font = preferredFont
            searchField.textColor = UIColor.gray

            // Set the background color of the search field.
            searchField.backgroundColor = barTintColor
            
            //Set searchbar placeholder color
            searchField.attributedPlaceholder = NSAttributedString(string:"Search Pokemon", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
            
            //search search icon color change
            let glassIconView =  searchField.leftView as! UIImageView
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = UIColor.gray
            
            
            //Set clearbutton image to white
            let clearBtn = searchField.value(forKey: "clearButton") as! UIButton
            clearBtn.setImage(clearBtn.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            clearBtn.tintColor = UIColor.white
        }
        
        super.draw(rect)
    }
}
