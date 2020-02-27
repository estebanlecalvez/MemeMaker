//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Service Informatique on 26/02/2020.
//  Copyright © 2020 MDS. All rights reserved.
//


import UIKit

import SwiftyJSON


class GenerateMemeViewController: UIViewController{
    var myData: JSON?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        print(myData)
        image.kf.setImage(with: URL(string:myData!["url"].stringValue))
        name.text = myData!["name"].stringValue
//        Ici Texte 1
        
        
//        Ici Texte 2
        
        
    }
    
    
}

