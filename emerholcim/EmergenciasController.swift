//
//  EmergenciasController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/13/19.
//

import UIKit


class EmergenciasController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var jsonArray: NSArray?
    var nombreArray: Array<String> = []
    var telefonoArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let zonp = UserDefaults.standard.value(forKey: "zonap") as! String
        cargardatos(zona: zonp)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nombreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonCell
        cell.nombre.text = self.nombreArray[indexPath.row]
        cell.telefono.text = self.telefonoArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let idseleccionado = self.telefonoArray[indexPath.row]
        Utils.call(numerocall: idseleccionado)
        
    }
    
    class Utils: NSObject {
        class func call(numerocall : String) {
            guard let number = URL(string: "tel://" + numerocall) else { return }
            UIApplication.shared.open(number)
            //UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
    }
    
    func cargardatos(zona : String){
        let postString = "idplanta=\(zona)"
        
        let url = URL(string: "http://appholcim.com/ccemergencia.php")!
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
                        
                        self.jsonArray = json as NSArray
                        
                        for item in self.jsonArray! as! [NSDictionary]{
                            let name = item["nombre"] as? String
                            let phone = item["telefono"] as? String
                            self.nombreArray.append(name!)
                            self.telefonoArray.append(phone!)
                            // print("\(String(describing: name)) y su telefono es: \(String(describing: phone))")
                            
                        }
                        
                        self.tableView.reloadData()
                        
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


