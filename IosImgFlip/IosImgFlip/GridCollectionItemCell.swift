//
//  GridCollectionItemCell.swift
//  IosImgFlip
//
//  Created by Service Informatique on 28/02/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import UIKit

class GridCollectionItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
}
