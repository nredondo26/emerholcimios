//
//  ReguladadosController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class ReguladadosController: UIViewController {
    
    @IBOutlet weak var imagendos: UIImageView!
    
    var datorecibidodos:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibidodos == "Eventos Vascular Cerebal"){
            imagendos.image = UIImage(named: "c300p.jpg")
        }
        
        if(datorecibidodos == "Síndrome Ortostatico"){
            imagendos.image = UIImage(named: "c301p.jpg")
        }
        
        if(datorecibidodos == "Dolor Precordial"){
            imagendos.image = UIImage(named: "c302p.jpg")
        }
        
        if(datorecibidodos == "Estado Mental Alterado"){
            imagendos.image = UIImage(named: "c303p.jpg")
        }
        
        if(datorecibidodos == "Convulsiones o Epilepsia"){
            imagendos.image = UIImage(named: "c304p.jpg")
        }
        
        if(datorecibidodos == "Crisis Hipertensiva/Migraña"){
            imagendos.image = UIImage(named: "c305p.jpg")
        }
        
        if(datorecibidodos == "Sangrado Nasal/Epistaxis"){
            imagendos.image = UIImage(named: "c306p.jpg")
        }
        
        if(datorecibidodos == "Embrazo de Riesgo"){
            imagendos.image = UIImage(named: "c307p.jpg")
        }
        
        
    }
    
}
