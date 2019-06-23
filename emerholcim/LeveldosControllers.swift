//
//  LeveldosControllers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/2/19.
//

import UIKit

class LeveldosController: UIViewController {
    
    @IBOutlet weak var imagendos: UIImageView!
    @IBOutlet weak var llamar911: boton!
    
    var jsonArray: NSArray?
    var numerof: String?
    
    var datorecibidodos:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(datorecibidodos == "Gripe o Catarro"){
            imagendos.image = UIImage(named: "c100p.jpg")
        }
        
        if(datorecibidodos == "Vérgito, Desmayo-Síncope"){
            imagendos.image = UIImage(named: "c101p.jpg")
        }
        
        if(datorecibidodos == "Malestar Estomacal"){
            imagendos.image = UIImage(named: "c102p.jpg")
        }
        
        if(datorecibidodos == "Esguince"){
            imagendos.image = UIImage(named: "c103p.jpg")
        }
        
        if(datorecibidodos == "Caída sin perdida de conciencia"){
            imagendos.image = UIImage(named: "c104p.jpg")
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
