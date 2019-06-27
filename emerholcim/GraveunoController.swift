//
//  GraveunoController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class GraveunoController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    var codigoenfermedad: String?
    @IBOutlet weak var bprocedimiento: UIButton!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
       if(datorecibido == "Paro Cardio-respiratorio(RCP)"){
            imagen.image = UIImage(named: "c200.jpg")
            codigoenfermedad = "200"
        }
        if(datorecibido == "Perdida del Estado de la Conciencia"){
            imagen.image = UIImage(named: "c201.jpg")
            codigoenfermedad = "201"
        }
        if(datorecibido == "Electrocucíon"){
            imagen.image = UIImage(named: "c202.jpg")
            codigoenfermedad = "202"
        }
        if(datorecibido == "Asfixia  / Atragantamiento"){
            imagen.image = UIImage(named: "c203.jpg")
            codigoenfermedad = "203"
        }
        if(datorecibido == "Trauma Cráneo-encefálico"){
            imagen.image = UIImage(named: "c204.jpg")
            codigoenfermedad = "204"
        }
        if(datorecibido == "Trauma Torácico"){
            imagen.image = UIImage(named: "c205.jpg")
            codigoenfermedad = "205"
        }
        if(datorecibido == "Trauma  de Columna"){
            imagen.image = UIImage(named: "c206.jpg")
            codigoenfermedad = "206"
        }
        if(datorecibido == "Trauma Térmico"){
            imagen.image = UIImage(named: "c207.jpg")
            codigoenfermedad = "207"
        }
        if(datorecibido == "Herídas y Fractras"){
            imagen.image = UIImage(named: "c208.jpg")
            codigoenfermedad = "208"
        }
        
    }
    
    @IBAction func bpaciente(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "paciente") as! PacienteController
        newViewController.codigoenfermedad =  codigoenfermedad
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true, completion: nil)
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
