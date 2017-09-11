//
//  PokeSegmenteControl.swift
//  Pokedex
//
//  Created by Fernando on 6/18/17.
//  Copyright © 2017 Specialist. All rights reserved.
//

import UIKit

class PokeSegmenteControl: UISegmentedControl {
    
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//         Drawing code
//    }


}
