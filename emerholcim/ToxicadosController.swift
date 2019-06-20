//
//  ToxicadosController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class ToxicadosController: UIViewController {
    
    
    @IBOutlet weak var imagendos: UIImageView!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Congestíon Alcohólica/ Etilismo"){
            imagendos.image = UIImage(named: "c400p.jpg")
        }
        
        if(datorecibido == "Efectos por uso de Drogas"){
            imagendos.image = UIImage(named: "c401p.jpg")
        }
        
        if(datorecibido == "Envenenamiento por Insectos"){
            imagendos.image = UIImage(named: "c402p.jpg")
        }
        
    }
    
    
}
