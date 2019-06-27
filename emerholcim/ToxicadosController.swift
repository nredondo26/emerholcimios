//
//  ToxicadosController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/3/19.
//

import UIKit

class ToxicadosController: UIViewController {
    
    
    @IBOutlet weak var imagendos: UIImageView!
    
    var jsonArray: NSArray?
    var numerof: String?
    
    var datorecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibido == "Congestíon Alcohólica/ Etilismo"){
            imagendos.image = UIImage(named: "c400p.jpg")
            
        }
        
        if(datorecibido == "Efectos por uso de Drogas"){
            imagendos.image = UIImage(named: "c401p.jpg")
            
        }
        
        if(datorecibido == "Envenenamiento por Insectos"){
            imagendos.image = UIImage(named: "c402p.jpg")
            
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
