//
//  LeveldosControllers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/2/19.
//

import UIKit

class LeveldosController: UIViewController {
    
    @IBOutlet weak var imagendos: UIImageView!
    
    var datorecibidodos:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibidodos == "Gripe o Catarro"){
            imagendos.image = UIImage(named: "c100p.jpg")
        }
        
        if(datorecibidodos == "Vérgito, Desmayo-Síncope"){
            imagendos.image = UIImage(named: "c101p.jpg")
        }
        
        if(datorecibidodos == "Malestar Estomacal"){
            imagendos.image = UIImage(named: "c102p.jpg")
        }
        
        if(datorecibidodos == "Esguince"){
            imagendos.image = UIImage(named: "c103p.jpg")
        }
        
        if(datorecibidodos == "Caída sin perdida de conciencia"){
            imagendos.image = UIImage(named: "c104p.jpg")
        }
               
    }
    
}
