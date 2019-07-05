//
//  ZonaController.swift
//  emerholcim
//
//  Created by nerb2019 on 7/4/19.
//

import UIKit

class ZonaController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let items = ["bellog","chiag","palmirag","floridag","nobsag","villavicenciog"]
    
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
        var campo: Int?
        
        if(opcion == 0){ campo = 1 }
        if(opcion == 1){ campo = 5 }
        if(opcion == 2){ campo = 6 }
        if(opcion == 3){ campo = 2 }
        if(opcion == 4){ campo = 4 }
        if(opcion == 5){ campo = 3 }
        
        self.performSegue(withIdentifier: "mostrarplantas", sender: campo)
        
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

