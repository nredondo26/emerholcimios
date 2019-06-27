//
//  Regutaladaunocontrollers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class ReguladaunoController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    
    var codigoenfermedad: String?
    
    @IBOutlet weak var bprocedimiento: UIButton!
    
    var datorecibido:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Eventos Vascular Cerebal"){
            imagen.image = UIImage(named: "c300.jpg")
            codigoenfermedad = "300"
        }
        
        if(datorecibido == "Síndrome Ortostatico"){
            imagen.image = UIImage(named: "c301.jpg")
            codigoenfermedad = "301"
        }
        
        if(datorecibido == "Dolor Precordial"){
            imagen.image = UIImage(named: "c302.jpg")
            codigoenfermedad = "302"
        }
        
        if(datorecibido == "Estado Mental Alterado"){
            imagen.image = UIImage(named: "c303.jpg")
            codigoenfermedad = "303"
        }
        
        if(datorecibido == "Convulsiones o Epilepsia"){
            imagen.image = UIImage(named: "c304.jpg")
            codigoenfermedad = "304"
        }
        
        if(datorecibido == "Crisis Hipertensiva/Migraña"){
            imagen.image = UIImage(named: "c305.jpg")
            codigoenfermedad = "305"
        }
        
        if(datorecibido == "Sangrado Nasal/Epistaxis"){
            imagen.image = UIImage(named: "c306.jpg")
            codigoenfermedad = "306"
        }
        
        if(datorecibido == "Embrazo de Riesgo"){
            imagen.image = UIImage(named: "c307.jpg")
            codigoenfermedad = "307"
        }
        
    }
    
    
    @IBAction func bpaciente(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "paciente") as! PacienteController
        newViewController.codigoenfermedad =  codigoenfermedad
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true, completion: nil)
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


