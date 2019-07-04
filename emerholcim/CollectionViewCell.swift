//
//  CollectionViewCell.swift
//  emerholcim
//
//  Created by nerb2019 on 7/4/19.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bookImage : UIImageView!
    
    func displayContent(image: UIImage) {
        bookImage.image = image
    }
    
}
