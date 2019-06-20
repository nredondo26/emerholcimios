//
//  GravedosController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class GravedosController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Paro Cardio-respiratorio(RCP)"){
            imagen.image = UIImage(named: "c200p.jpg")
        }
        if(datorecibido == "Perdida del Estado de la Conciencia"){
            imagen.image = UIImage(named: "c201p.jpg")
        }
        if(datorecibido == "Electrocucíon"){
            imagen.image = UIImage(named: "c202p.jpg")
        }
        if(datorecibido == "Asfixia  / Atragantamiento"){
            imagen.image = UIImage(named: "c203p.jpg")
        }
        if(datorecibido == "Trauma Cráneo-encefálico"){
            imagen.image = UIImage(named: "c204p.jpg")
        }
        if(datorecibido == "Trauma Torácico"){
            imagen.image = UIImage(named: "c205p.jpg")
        }
        if(datorecibido == "Trauma  de Columna"){
            imagen.image = UIImage(named: "c206p.jpg")
        }
        if(datorecibido == "Trauma Térmico"){
            imagen.image = UIImage(named: "c207p.jpg")
        }
        if(datorecibido == "Herídas y Fractras"){
            imagen.image = UIImage(named: "c208p.jpg")
        }
        
    }
    
    
}
