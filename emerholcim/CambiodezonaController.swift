//
//  CambiodezonaController.swift
//  emerholcim
//
//  Created by nerb2019 on 7/5/19.
//

import UIKit

class CambiodezonaController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nombreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Zonacell
        cell.nombre.text = self.nombreArray[indexPath.row]
        cell.imagen.text = self.imagenArray[indexPath.row]
        cell.id.text = self.idArray[indexPath.row]
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let idseleccionado = self.telefonoArray[indexPath.row]
        Utils.call(numerocall: idseleccionado)
        
    }*/
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var datorecibido: Int?

    var jsonArray: NSArray?
    var nombreArray: Array<String> = []
    var idArray: Array<String> = []
    var imagenArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
                
                    print("recibimos respuesta")
                
                if let json = try JSONSerialization.jsonObject(with: data) as? Array<Any> {
                    
                    DispatchQueue.main.async {
                        
                      //  print(json)
                        
                        self.jsonArray = json as NSArray
                        
                        for item in self.jsonArray! as! [NSDictionary]{
                            let nombre = item["nombre"] as? String
                            let imagen = item["imagen"] as? String
                            let id = item["id"] as? String
                            self.nombreArray.append(nombre!)
                            self.imagenArray.append(imagen!)
                            self.idArray.append(id!)
                             print("\(String(describing: nombre)) y su telefono es: \(String(describing: imagen))")
                            
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
