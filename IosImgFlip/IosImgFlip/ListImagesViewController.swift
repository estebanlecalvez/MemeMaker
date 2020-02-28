//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Service Informatique on 07/02/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher


class ListImageViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var memes:[JSON] = []
    
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        getMemes(searchTerms: "")
    }
    
    func searchBar(_ searchBar: UISearchBar,textDidChange searchText:String){
        getMemes(searchTerms: searchText)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func getMemes(searchTerms: String){
        let url = URL(string:"https://api.imgflip.com/get_memes")
        var request = URLRequest(url:url!)
        request.httpMethod = "get"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let json = try JSON(data:data!)
                if let memes = json["data"]["memes"].array {
                    self.memes = []
                    for meme in memes {
                        
                        if(meme["box_count"].intValue < 3){
                            let name = meme["name"].stringValue
                            if searchTerms == ""{
                                self.memes.append(JSON(meme))
                            }else if name.contains(searchTerms) {
                                 self.memes.append(JSON(meme))
                            }
                        }
                    }
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                }
            }catch(let catchedError){
                print("error in parsing \(catchedError)")
            }
        }.resume()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        let titleLabel:UILabel = cell.viewWithTag(1) as! UILabel
        let image:UIImageView = cell.viewWithTag(2) as! UIImageView
        titleLabel.text = self.memes[indexPath.row]["name"].stringValue
        
        let url = URL(string:self.memes[indexPath.row]["url"].stringValue)
        image.kf.setImage(with:url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard:UIStoryboard = UIStoryboard(name:"Main",bundle: nil)
        let pokemonDetailViewController = storyboard.instantiateViewController(withIdentifier: "GenerateMemeViewControllerID") as! GenerateMemeViewController
        pokemonDetailViewController.myData = memes[indexPath.row]
        self.present(pokemonDetailViewController, animated: true, completion: nil)
    }
    
    
}
