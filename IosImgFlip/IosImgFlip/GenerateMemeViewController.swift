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
    var imageToShare: String?
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var foregroundImageLoader: UIView!
    
    override func viewDidLoad() {
        image.kf.setImage(with: URL(string:myData!["url"].stringValue))
        name.text = myData!["name"].stringValue
    }
    @IBAction func onButtonPressed(_ sender: Any) {
        changeImage()
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        let activityItem: [AnyObject] = [self.image.image!]
        
        let avc = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        
        self.present(avc, animated: true, completion: nil)
    }
    
    func changeImage(){
        let url = URL(string: "https://api.imgflip.com/caption_image")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let text1 = self.firstText.text
        let text2 = self.secondText.text
        let params = [
            "username":"iosapi2020",
            "password":"iosapi2020",
            "template_id":myData!["id"].stringValue,
            "boxes[0][text]":text1!,
            "boxes[1][text]":text2!,
        ]
        let jsonString = params.reduce("") { "\($0)\($1.0)=\($1.1)&" }
        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
        request.httpBody  = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let json = try JSON(data:data!)
                let url = json["data"]["url"]
                
                if(json["success"].boolValue == true){
                    DispatchQueue.main.async{
                        self.imageToShare = url.stringValue
                        self.image.kf.setImage(with: URL(string:url.stringValue))
                    }
                }
                //               fixme:toast
            }catch(let catchedError){
                print("error in parsing \(catchedError)")
            }
        }.resume()
    }
    
}

