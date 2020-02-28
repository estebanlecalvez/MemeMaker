//
//  itemCellCollectionViewCell.swift
//  IosImgFlip
//
//  Created by Service Informatique on 28/02/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import UIKit

class itemCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(name:String,image:String){
        self.image.kf.setImage(with: URL(string:image))
        self.label.text = name
    }

}
