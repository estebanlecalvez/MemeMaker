//
//  GridViewMemeViewController.swift
//  IosImgFlip
//
//  Created by Service Informatique on 28/02/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher


class GridViewMemeViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var memes:[JSON] = []
    
    
    @IBOutlet var gridView: UICollectionView!
    override func viewDidLoad() {
        self.collectionView.delegate = self
        getMemes()
    }
    
    func getMemes(){
        let url = URL(string:"https://api.imgflip.com/get_memes")
        var request = URLRequest(url:url!)
        request.httpMethod = "get"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let json = try JSON(data:data!)
                if let memes = json["data"]["memes"].array {
                    for meme in memes {
                        if(meme["box_count"].intValue < 3){
                            self.memes.append(JSON(meme))
                            
                        }
                    }
                    DispatchQueue.main.async{
                        self.gridView.reloadData()
                    }
                }
            }catch(let catchedError){
                print("error in parsing \(catchedError)")
            }
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 2.0) + (flowayout?.sectionInset.right ?? 2.0)

        let size:CGFloat = (collectionView.frame.size.width) / 2.0
        return CGSize(width:size,height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gridView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let titleLabel:UILabel = cell.viewWithTag(2) as! UILabel
               let image:UIImageView = cell.viewWithTag(3) as! UIImageView
               
               titleLabel.text = self.memes[indexPath.row]["name"].stringValue
               
               let url = URL(string:self.memes[indexPath.row]["url"].stringValue)
               image.kf.setImage(with:url)
        return cell
    }
    
}
