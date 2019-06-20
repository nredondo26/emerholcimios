//
//  Regutaladaunocontrollers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class ReguladaunoController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    
    
    @IBOutlet weak var bprocedimiento: UIButton!
    
    var datorecibido:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Eventos Vascular Cerebal"){
            imagen.image = UIImage(named: "c300.jpg")
        }
        
        if(datorecibido == "Síndrome Ortostatico"){
            imagen.image = UIImage(named: "c301.jpg")
        }
        
        if(datorecibido == "Dolor Precordial"){
            imagen.image = UIImage(named: "c302.jpg")
        }
        
        if(datorecibido == "Estado Mental Alterado"){
            imagen.image = UIImage(named: "c303.jpg")
        }
        
        if(datorecibido == "Convulsiones o Epilepsia"){
            imagen.image = UIImage(named: "c304.jpg")
        }
        
        if(datorecibido == "Crisis Hipertensiva/Migraña"){
            imagen.image = UIImage(named: "c305.jpg")
        }
        
        if(datorecibido == "Sangrado Nasal/Epistaxis"){
            imagen.image = UIImage(named: "c306.jpg")
        }
        
        if(datorecibido == "Embrazo de Riesgo"){
            imagen.image = UIImage(named: "c307.jpg")
        }
        
    }
    
    
    @IBAction func fbprocedimiento(_ sender: Any) {
        self.performSegue(withIdentifier: "leveldosr", sender: datorecibido)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "leveldosr"){
            
            let idseleccionadorecibido = sender as! String
            let objleveldos : ReguladadosController = segue.destination as! ReguladadosController
            objleveldos.datorecibidodos = idseleccionadorecibido
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    
    
    
}


