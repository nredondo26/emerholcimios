//
//  Levelunocontrollers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/2/19.
//

import UIKit

class LevelunoController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!

    @IBOutlet weak var bprocedimiento: UIButton!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Gripe o Catarro"){
            imagen.image = UIImage(named: "c100.jpg")
        }
        
        if(datorecibido == "Vérgito, Desmayo-Síncope"){
            imagen.image = UIImage(named: "c101.jpg")
        }
        
        if(datorecibido == "Malestar Estomacal"){
            imagen.image = UIImage(named: "c102.jpg")
        }
        
        if(datorecibido == "Esguince"){
            imagen.image = UIImage(named: "c103.jpg")
        }
        
        if(datorecibido == "Caída sin perdida de conciencia"){
            imagen.image = UIImage(named: "c104.jpg")
        }
        
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

