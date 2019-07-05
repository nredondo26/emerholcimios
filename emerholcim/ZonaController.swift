//
//  ZonaController.swift
//  emerholcim
//
//  Created by nerb2019 on 7/4/19.
//

import UIKit

class ZonaController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let items = ["bellog","chiag","floridag","nobsag","palmirag","villavicenciog"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.imagen.image = UIImage(named: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
    
    
}

