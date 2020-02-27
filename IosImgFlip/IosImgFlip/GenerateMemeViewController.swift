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
//        let postData = NSMutableData(data: "UserID=351".data(using: String.Encoding.utf8)!)
//        let urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api.imgflip.com/caption_image")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        let params = ["username":"iosapi2020",
//        "password":"iosapi2020",
//        "template_id":myData!["id"].stringValue,
//        "max_font_size":"20",
//        "boxes[0][text]":"David",
//        "boxes[1][text]":"Tofigh",
//        ]
//        let jsonString = params.reduce("") { "\($0)\($1.0)=\($1.1)&" }
//        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
//        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
//        urlRequest.httpBody  = jsonData
//
        
        
        
        let url = URL(string: "https://api.imgflip.com/caption_image")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
       let params = [
            "username":"iosapi2020",
           "password":"iosapi2020",
           "template_id":myData!["id"].stringValue,
           "boxes[0][text]":"David",
           "boxes[1][text]":"Tofigh",
       ]
       let jsonString = params.reduce("") { "\($0)\($1.0)=\($1.1)&" }
       let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
       request.httpBody  = jsonData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let json = try JSON(data:data!)
                print(json)
            }catch(let catchedError){
                print("error in parsing \(catchedError)")
            }
        }.resume()
        
//        print(myData)
        image.kf.setImage(with: URL(string:myData!["url"].stringValue))
        name.text = myData!["name"].stringValue
//        Ici Texte 1
        
        
//        Ici Texte 2
        
        
    }
    
    
}

