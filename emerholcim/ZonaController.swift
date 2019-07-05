//
//  ZonaController.swift
//  emerholcim
//
//  Created by nerb2019 on 7/4/19.
//

import UIKit

class ZonaController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let items = ["bellog","palmirag","chiag","floridag","nobsag","villavicenciog"]
    
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
        
        let opcion = indexPath.row
        
        self.performSegue(withIdentifier: "mostrarplantas", sender: opcion)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "mostrarplantas"){
            
            let recibido = sender!
            
            print(recibido)
            
            let objeto : CambiodezonaController = segue.destination  as! CambiodezonaController
            
            objeto.datorecibido = recibido as? Int
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
  
}

