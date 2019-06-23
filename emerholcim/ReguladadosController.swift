//
//  ReguladadosController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class ReguladadosController: UIViewController {
    
    @IBOutlet weak var imagendos: UIImageView!
    
    var jsonArray: NSArray?
    var numerof: String?
    
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
    
    @IBAction func llamar(_ sender: Any) {
        let zonp = UserDefaults.standard.value(forKey: "zonap") as! String
        llenar(zona: zonp)
    }
    
    func llenar(zona: String) {
        let postString = "idplanta=\(zona)"
        let url = URL(string: "http://appholcim.com/nueveonce.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"//tipo de envio -> metodo post
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {//si existe un error se termina la funcion
                print("solicitud fallida \(String(describing: error))")//manejamos el error
                return //rompemos el bloque de codigo
            }
            do {//creamos nuestro objeto json
                
                if let json = try JSONSerialization.jsonObject(with: data) as? Array<Any> {
                    DispatchQueue.main.async {
                        self.jsonArray = json as NSArray
                        for item in self.jsonArray! as! [NSDictionary]{
                            let numero = item["numero"] as? String
                            self.numerof = numero
                        }
                        Utils.call(numerocall: self.numerof!)
                    }
                }
            } catch let parseError {//manejamos el error
                print("error al parsear: \(parseError)")
                let responseString = String(data: data, encoding: .utf8)
                print("respuesta : \(String(describing: responseString))")
            }
        }
        task.resume()
    }
    
    class Utils: NSObject {
        class func call(numerocall : String) {
            guard let number = URL(string: "tel://" + numerocall) else { return }
            UIApplication.shared.open(number)
            //UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
    }
    
}
