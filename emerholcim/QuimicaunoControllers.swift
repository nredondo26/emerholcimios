//
//  QuimicaunoControllers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class QuimicaunoController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var bpro: UIButton!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Riesgo Químico"){
            imagen.image = UIImage(named: "c500.jpg")
        }
  }
    
    @IBAction func fbprocedimiento(_ sender: Any) {
        self.performSegue(withIdentifier: "segueqdos", sender: datorecibido)
        print("salio del boton")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueqdos"){
            
            print("entro en el if del segue")
            
            let idseleccionadorecibido = sender as! String
            let objleveldos : QuimicadosController = segue.destination as! QuimicadosController
            objleveldos.datorecibido = idseleccionadorecibido
            
            print("finalizo el segue")
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    
    
    
    
}


//
