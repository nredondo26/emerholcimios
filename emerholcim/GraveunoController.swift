//
//  GraveunoController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class GraveunoController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var bprocedimiento: UIButton!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
       if(datorecibido == "Paro Cardio-respiratorio(RCP)"){
            imagen.image = UIImage(named: "c200.jpg")
        }
        if(datorecibido == "Perdida del Estado de la Conciencia"){
            imagen.image = UIImage(named: "c201.jpg")
        }
        if(datorecibido == "Electrocucíon"){
            imagen.image = UIImage(named: "c202.jpg")
        }
        if(datorecibido == "Asfixia  / Atragantamiento"){
            imagen.image = UIImage(named: "c203.jpg")
        }
        if(datorecibido == "Trauma Cráneo-encefálico"){
            imagen.image = UIImage(named: "c204.jpg")
        }
        if(datorecibido == "Trauma Torácico"){
            imagen.image = UIImage(named: "c205.jpg")
        }
        if(datorecibido == "Trauma  de Columna"){
            imagen.image = UIImage(named: "c206.jpg")
        }
        if(datorecibido == "Trauma Térmico"){
            imagen.image = UIImage(named: "c207.jpg")
        }
        if(datorecibido == "Herídas y Fractras"){
            imagen.image = UIImage(named: "c208.jpg")
        }
        
    }
    
    
    @IBAction func fbprocedim(_ sender: Any) {
        self.performSegue(withIdentifier: "leveldosg", sender: datorecibido)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "leveldosg"){
            
            print("entro en el if del segue")
            
            let idseleccionadorecibido = sender as! String
            let objleveldos : GravedosController = segue.destination as! GravedosController
            objleveldos.datorecibido = idseleccionadorecibido
            
            print("finalizo el segue")
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    
}
