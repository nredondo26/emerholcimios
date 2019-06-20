//
//  QuimicadosController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class QuimicadosController: UIViewController {
    
    @IBOutlet weak var imagendos: UIImageView!
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Riesgo Químico"){
            imagendos.image = UIImage(named: "c500p.jpg")
        }
        
    }
    
    
}
