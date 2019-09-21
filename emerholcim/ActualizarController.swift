//
//  ActualizarController.swift
//  emerholcim
//
//  Created by nerb2019 on 7/2/19.
//

import UIKit
import Alamofire
import Toaster
import Toast_Swift
import iOSDropDown

class ActualizarController: UIViewController{
    
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var zona: DropDown!
    @IBOutlet weak var cargos: DropDown!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    
    let plantas = ["Bello",
                   "Buga",
                   "Cali Sur",
                   "Cemento",
                   "Chía" ,
                   "Floridablanca",
                   "Nobsa",
                   "Palmira",
                   "Puente Aranda",
                   "Ricaurte",
                   "Teleport",
                   "Tunja",
                   "La Flor",
                   "Pipiral"]
    
    let listacargos = ["Jefe de Brigada",
                       "Jefe de Brigada",
                       "Jefe de Brigada Zona I",
                       "Jefe de Brigada Zona III",
                       "Jefe de Brigada Zona II",
                       "Líder de Brigada de Primeros Aux",
                       "Líder de Brigada de Prevención y c",
                       "incendios",
                       "Líder de Brigada de Evacuación, b",
                       "Líder de Brigada de Comunicación",
                       "Responsable de la Instalación",
                       "Responsable de H&S de la Instala",
                       "Responsable local de Suministros",
                       "Responsable local del área Legal",
                       "Responsable local de RH",
                       "Responsable local de IT",
                       "Suplente de Jefe de Brigada",
                       "Suplente Jefe de Brigada Zona III",
                       "Brigadista de Evacuación/Suplente Jefe de Brigada Zona I",
                       "Brigadista de Primeros Auxilios",
                       "Brigadista de Prevención y Combate de Incendios",
                       "Brigadista de Evacuación",
                       "Brigadista de Primeros Auxilios",
                       "Brigadista de Prevención y Combate de Incendios",
                       "Brigadista de Evacuación",
                       "Brigadista de Evacuación/Suplente Jefe de Brigada Zona II",
                       "Brigadista de Primeros Auxilios",
                       "Brigadista de Prevención y Combate de Incendios",
                       "Brigadista de Evacuación",
                       "Médico Responsable",
                       "rescate",
                       "Otros",
                       "Visitante",
                       "Trabajador no Holcim"]
    
    var valor: String?
    var valorr: Int?
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        solomostrar()
        
        zona.optionArray = plantas
        cargos.optionArray = listacargos
        
    }
    
    func solomostrar(){
        
        let nomp:String = UserDefaults.standard.value(forKey: "nombrep") as! String
        let apellp:String = UserDefaults.standard.value(forKey: "apellidosp") as! String
        let areap = UserDefaults.standard.value(forKey: "areap") as! String
        let zonp = UserDefaults.standard.value(forKey: "zonap") as! String
        let emailp = UserDefaults.standard.value(forKey: "emailp") as! String
        let passwordp = UserDefaults.standard.value(forKey: "passwordp") as! String
        
        self.nombre.text = "\(nomp)"
        self.apellidos.text = "\(apellp)"
        self.cargos.text = areap
        self.zona.text = self.zonainfodos(zona: zonp)
        self.email.text = "\(emailp)"
        self.password.text = "\(passwordp)"

    }
    
    func zonainfo(zona: String) -> String {
        var zonaf: String?
        if zona == "Bello" { zonaf = "1" }
        if zona == "Buga" { zonaf = "2" }
        if zona == "Cali Sur" { zonaf = "3" }
        if zona == "Cemento" { zonaf = "4" }
        if zona == "Chía" { zonaf = "5" }
        if zona == "Floridablanca" { zonaf = "6" }
        if zona == "Nobsa" { zonaf = "7" }
        if zona == "Palmira" { zonaf = "8" }
        if zona == "Puente Aranda" { zonaf = "9" }
        if zona == "Ricaurte" { zonaf = "10" }
        if zona == "Teleport" { zonaf = "11" }
        if zona == "Tunja" { zonaf = "12" }
        if zona == "La Flor" { zonaf = "13" }
        if zona == "Pipiral" { zonaf = "27" }
        return zonaf!
}
 
    func zonainfodos(zona: String) -> String {
        var zonaf: String?
        if zona == "1" { zonaf = "Bello" }
        if zona == "2" { zonaf = "Buga" }
        if zona == "3" { zonaf = "Cali Sur" }
        if zona == "4" { zonaf = "Cemento" }
        if zona == "5" { zonaf = "Chía" }
        if zona == "6" { zonaf = "Floridablanca" }
        if zona == "7" { zonaf = "Nobsa" }
        if zona == "8" { zonaf = "Palmira" }
        if zona == "9" { zonaf = "Puente Aranda" }
        if zona == "10" { zonaf = "Ricaurte" }
        if zona == "11" { zonaf = "Teleport" }
        if zona == "12" { zonaf = "1Tunja" }
        if zona == "13" { zonaf = "La Flor" }
        if zona == "27" { zonaf = "Pipiral" }
        return zonaf!
    }

    
    @IBAction func Actualizarinformacionp(_ sender: Any) {
        actualizar()
    }
    
    func actualizar() {
        
        let nombrer = nombre.text!
        let apellidosr = apellidos.text!
        let zonar = zona.text!
        let cargosr = cargos.text!
        let emailr = email.text!
        let passwordr = password.text!
        let idr = UserDefaults.standard.value(forKey: "id")
        
        if( nombrer == "" || apellidosr == "" || zonar == "" || cargosr == "" || emailr == "" || passwordr == ""){
            print("campos vacios")
            return
        }
        
        let postString = "nombre=\(nombrer)&apellidos=\(apellidosr)&zona=\(zonainfo(zona: zonar))&area=\(cargosr)&email=\(emailr)&password=\(passwordr)&id=\(idr!)"
        
        print("envar solicitud \(postString)")
        
        let url = URL(string: "http://appholcim.com/actualizar.php")!
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
                
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                    
                    DispatchQueue.main.async {//proceso principal
                        
                        print(json["estado"]!)
                        let repuesta = json["estado"]!
                        if(repuesta == "si"){
                            
                            Toast(text: "Informacion Actualizada").show()
                            
                            let domain = Bundle.main.bundleIdentifier!
                            UserDefaults.standard.removePersistentDomain(forName: domain)
                            UserDefaults.standard.synchronize()
                            
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginp") as! ViewController
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            self.present(newViewController, animated: true, completion: nil)
                            
                        }else{
                            Toast(text: "Informacion no actualizada").show()
                        }
                        
                    }
                }
                
            } catch let parseError {//manejamos el error
                print("error al parsear: \(parseError)")
                //self.errorLabel.text = "error del servidor (json)";
                
                let responseString = String(data: data, encoding: .utf8)
                print("respuesta : \(String(describing: responseString))")
            }
        }
        task.resume()
    }
    
    

}
