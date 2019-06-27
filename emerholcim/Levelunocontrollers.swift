//
//  Levelunocontrollers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/2/19.
//

import UIKit

class LevelunoController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    
    var codigoenfermedad: String?

    @IBOutlet weak var bprocedimiento: UIButton!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Gripe o Catarro"){
            imagen.image = UIImage(named: "c100.jpg")
            codigoenfermedad = "100"
        }
        
        if(datorecibido == "Vérgito, Desmayo-Síncope"){
            imagen.image = UIImage(named: "c101.jpg")
            codigoenfermedad = "101"
        }
        
        if(datorecibido == "Malestar Estomacal"){
            imagen.image = UIImage(named: "c102.jpg")
            codigoenfermedad = "102"
        }
        
        if(datorecibido == "Esguince"){
            imagen.image = UIImage(named: "c103.jpg")
            codigoenfermedad = "103"
        }
        
        if(datorecibido == "Caída sin perdida de conciencia"){
            imagen.image = UIImage(named: "c104.jpg")
            codigoenfermedad = "104"
        }
        
    }
    
    
    @IBAction func Bpaciente(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "paciente") as! PacienteController
        newViewController.codigoenfermedad =  codigoenfermedad
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func fbprocedimiento(_ sender: Any) {
        self.performSegue(withIdentifier: "leveldos", sender: datorecibido)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "leveldos"){
            
            let idseleccionadorecibido = sender as! String
            let objleveldos : LeveldosController = segue.destination as! LeveldosController
            objleveldos.datorecibidodos = idseleccionadorecibido
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    
    
    

    
    
}

