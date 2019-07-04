//
//  ListaMapaController.swift
//  emerholcim
//
//  Created by nerb2019 on 7/4/19.
//

import UIKit

class ListaMapaController :UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var colletionview: UICollectionView!
    
    var nombreArray: Array<String> = ["mapa","mapa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.nombreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
         cell.displayContent(image: indexPath.row)
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoordenadasCell
        cell.nombre.text = self.nombreArray[indexPath.row]
        return cell
    }
    
    
}
