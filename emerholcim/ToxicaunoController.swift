//
//  ToxicaunoController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class ToxicaunoController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    var codigoenfermedad: String?
    @IBOutlet weak var bproce: UIButton!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Congestíon Alcohólica/ Etilismo"){
            imagen.image = UIImage(named: "c400.jpg")
            codigoenfermedad = "400"
        }
        
        if(datorecibido == "Efectos por uso de Drogas"){
            imagen.image = UIImage(named: "c401.jpg")
            codigoenfermedad = "401"
        }
        
        if(datorecibido == "Envenenamiento por Insectos"){
            imagen.image = UIImage(named: "c402.jpg")
            codigoenfermedad = "402"
        }
        
        
  }
    
    @IBAction func bpaciente(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "paciente") as! PacienteController
        newViewController.codigoenfermedad =  codigoenfermedad
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true, completion: nil)
    }
    

    @IBAction func fbprocedi(_ sender: Any) {
        
        self.performSegue(withIdentifier: "leveldost", sender: datorecibido)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "leveldost"){
            
            print("entro en el if del segue")
            
            let idseleccionadorecibido = sender as! String
            let objleveldos : ToxicadosController = segue.destination as! ToxicadosController
            objleveldos.datorecibido = idseleccionadorecibido
            
            print("finalizo el segue")
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    
}

