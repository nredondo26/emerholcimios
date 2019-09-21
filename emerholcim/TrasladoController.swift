//
//  TrasladoController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/15/19.
//

import UIKit


class TrasladoController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tabla: UITableView!
    var nombreArray: Array<String> = []
    var direccionArray: Array<String> = []
    var latitudArray: Array<String> = []
    var longitudArray: Array<String> = []
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoordenadasCell
        cell.nombre.text = self.nombreArray[indexPath.row]
        cell.direccion.text = self.direccionArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let latseleccionado = self.latitudArray[indexPath.row]
        let longseleccionado = self.longitudArray[indexPath.row]
        
      //  print("La latitud es: \(latseleccionado) y la longitud es: \(longseleccionado)")
        
        self.performSegue(withIdentifier: "pasarcoordenadas", sender: [latseleccionado,longseleccionado])
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "pasarcoordenadas"){
            let recibido = sender as! Array<Any>
            
            let n1 = recibido[0]
            let n2 = recibido[1]
            
            let objleveluno : mapa = segue.destination as! mapa
            objleveluno.latitudrecibido = n1 as? String
            objleveluno.longitudrecibido = n2 as? String
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
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
                            let lat = item["latitud"] as? String
                            let long = item["longitud"] as? String
                            self.nombreArray.append(name!)
                            self.direccionArray.append(dire!)
                            self.latitudArray.append(lat!)
                            self.longitudArray.append(long!)
                            // print("\(String(describing: name)) y su telefono es: \(String(describing: phone))")
                            
                        }
                        
                        self.tabla.reloadData()
                        
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


