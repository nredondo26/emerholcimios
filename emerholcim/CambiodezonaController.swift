//
//  CambiodezonaController.swift
//  emerholcim
//
//  Created by nerb2019 on 7/5/19.
//

import UIKit

class CambiodezonaController: UIViewController {
    
    var datorecibido: Int?
    
    var jsonArray: NSArray?
    var nombreArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargardatos(region: datorecibido!)
        
    }
    
    func cargardatos(region : Int){
        let postString = "region=\(region)"
        
        let url = URL(string: "http://appholcim.com/inicio.php")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"//tipo de envio -> metodo post
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {//si existe un error se termina la funcion
                // self.errorLabel.text = "error del servidor";
                print("solicitud fallida \(String(describing: error))")//manejamos el error
                return //rompemos el bloque de codigo
            }
            
            do {//creamos nuestro objeto json
                
                //    print("recibimos respuesta")
                
                if let json = try JSONSerialization.jsonObject(with: data) as? Array<Any> {
                    
                    DispatchQueue.main.async {
                        
                        print(json)
                        
                       /* self.jsonArray = json as NSArray
                        
                        for item in self.jsonArray! as! [NSDictionary]{
                           /* let name = item["nombre"] as? String
                            let phone = item["telefono"] as? String
                            self.nombreArray.append(name!)
                            self.telefonoArray.append(phone!)*/
                            // print("\(String(describing: name)) y su telefono es: \(String(describing: phone))")
                            
                        }*/
                        
                      //  self.tableView.reloadData()
                        
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
    
    
}
