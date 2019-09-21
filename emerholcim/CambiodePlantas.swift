//
//  CambiodePlantas.swift
//  emerholcim
//
//  Created by nerb2019 on 7/3/19.
//

import UIKit


class CambiodePlantas: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tabla: UITableView!
    
    var nombreArray: Array<String> = []
    var imagenArray: Array<String> = []
    var jsonArray: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabla.delegate = self
        self.tabla.dataSource = self
        
        let id = UserDefaults.standard.value(forKey: "id") as! String
        cargardatos(id: id)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nombreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlantasCell
        cell.nombreplanta.text = self.nombreArray[indexPath.row]
       // cell.direccion.text = self.direccionArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // let latseleccionado = self.latitudArray[indexPath.row]
      //  let longseleccionado = self.longitudArray[indexPath.row]
        
        //  print("La latitud es: \(latseleccionado) y la longitud es: \(longseleccionado)")
        
      //  self.performSegue(withIdentifier: "pasarcoordenadas", sender: [latseleccionado,longseleccionado])
        
    }
    
    
    func cargardatos(id : String){
        let postString = "id=\(id)"
        
        let url = URL(string: "http://appholcim.com/centrosmedicos.php")!
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
                            let dire = item["direccion"] as? String
                           
                            self.nombreArray.append(name!)
                            self.imagenArray.append(dire!)
                         
                            // print("\(String(describing: name)) y su telefono es: \(String(describing: phone))")
                            
                        }
                        
                  //      self.tabla.reloadData()
                        
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


