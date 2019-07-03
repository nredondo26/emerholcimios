//
//  MenuController.swift
//  emerholcim
//
//  Created by nerb2019 on 5/30/19.
//

import UIKit
import Toast_Swift
import Toaster

class MenuController: UIViewController {
    
    @IBOutlet weak var txtnombre: UILabel!
    @IBOutlet weak var txtcargo: UILabel!
    @IBOutlet weak var txtzona: UILabel!
    @IBOutlet weak var imagenperfil: UIImageView!
    @IBOutlet weak var opciones: UIButton!
    
    var nombre:String?
    var apellidos:String?
    var puesto:String?
    var zona: String?
    var email: String?
    var passs: String?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if comprovarpreferencias() {
            solomostrar()
        }else{
            llenar(correo: email!, clavee: passs!)
        }
    }
    
    
    @IBAction func opciones(_ sender: Any) {
        
        func printActionTitle(_ action: UIAlertAction) {
            print("You tapped \(action.title!)")
        }
        
        func cerrarsesion(_ action: UIAlertAction){
            self.cerrar()
        }
        
        func eliminarcuenta(_ action: UIAlertAction){
            self.eliminar()
        }
        
        func cambiarzona(_ action: UIAlertAction){
            self.cambiarzonas()
        }
        
        func editarinformacion(_ action: UIAlertAction){
            self.editarinfo()
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cambiar de zona", style: .default, handler: cambiarzona))
        alertController.addAction(UIAlertAction(title: "Editar Informacion", style: .default, handler: editarinformacion))
        alertController.addAction(UIAlertAction(title: "Eliminar Cuenta", style: .destructive, handler: eliminarcuenta))
        alertController.addAction(UIAlertAction(title: "Cerrar Sesión", style: .default, handler: cerrarsesion))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: printActionTitle))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func cambiarzonas(){
        
    }
    
    func editarinfo(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "editarperfil") as! ActualizarController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true, completion: nil)
    }

    
    func eliminar(){
        let iddoctenido = UserDefaults.standard.value(forKey: "id")
        
        let postString = "id=\(iddoctenido!)"
        let url = URL(string: "http://appholcim.com/eliminarcuenta.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"//tipo de envio -> metodo post
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {//si existe un error se termina la funcion
                print("solicitud fallida \(String(describing: error))")//manejamos el error
                return //rompemos el bloque de codigo
            }
            do {//creamos nuestro objeto json
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                    DispatchQueue.main.async {//proceso principal
                        let estado = json["estado"]//constante
                        if (estado == "si"){
                            Toast(text: "Usuario Eliminado Correctamente").show()
                            self.cerrar()
                        }
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
    
    func cerrar()  {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginp") as! ViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func comprovarpreferencias() -> Bool {
        let emailp = UserDefaults.standard.value(forKey: "emailp")
        if(emailp != nil){
            return true
        }else{
            return false
        }
    }
    
    func solomostrar(){
        
        let nomp:String = UserDefaults.standard.value(forKey: "nombrep") as! String
        let apellp:String = UserDefaults.standard.value(forKey: "apellidosp") as! String
        let areap = UserDefaults.standard.value(forKey: "areap") as! String
        let zonp = UserDefaults.standard.value(forKey: "zonap") as! String
        let imagpp = UserDefaults.standard.value(forKey: "imagenperfilp")
        
        
        self.txtnombre.text = "\(nomp) \(apellp)"
        self.txtcargo.text = areap
        self.txtzona.text = self.zonainfo(zona: zonp)
        self.cargarimagen(img: imagpp as! String)
        
    }
    
    
    func llenar(correo: String, clavee: String) {
        
        let postString = "email=\(correo)&password=\(clavee)"
        let url = URL(string: "http://appholcim.com/consultaruser.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"//tipo de envio -> metodo post
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {//si existe un error se termina la funcion
                print("solicitud fallida \(String(describing: error))")//manejamos el error
                return //rompemos el bloque de codigo
            }
            do {//creamos nuestro objeto json
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                    DispatchQueue.main.async {//proceso principal
                        let estado = json["id"]//constante
                        self.extraer(idd: estado!)
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
    
    func extraer(idd: String) {
        let postString = "id=\(idd)"
        let url = URL(string: "http://appholcim.com/extraertodo.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"//tipo de envio -> metodo post
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {//si existe un error se termina la funcion
                print("solicitud fallida \(String(describing: error))")//manejamos el error
                return //rompemos el bloque de codigo
            }
            do {//creamos nuestro objeto json
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                    DispatchQueue.main.async {//proceso principal
                        
                        let nombre = json["nombre"]
                        let aapellidos = json["apellidos"]
                        let area = json["area"]
                        let zona = json["zona"]
                        let imagenperfil = json["imagenperfil"]
                        let emaill = json["email"]
                        let passww = json["password"]
                        let idd = json["id"]
                        
                        self.txtnombre.text = nombre! + " " + aapellidos!
                        self.txtcargo.text = area
                        self.txtzona.text = self.zonainfo(zona: zona!)
                        self.cargarimagen(img: imagenperfil!)
                        
                        UserDefaults.standard.setValue(nombre, forKey: "nombrep")
                        UserDefaults.standard.setValue(aapellidos, forKey: "apellidosp")
                        UserDefaults.standard.setValue(area, forKey: "areap")
                        UserDefaults.standard.setValue(zona, forKey: "zonap")
                        UserDefaults.standard.setValue(imagenperfil, forKey: "imagenperfilp")
                        UserDefaults.standard.setValue(emaill, forKey: "emailp")
                        UserDefaults.standard.setValue(passww, forKey: "passwordp")
                        UserDefaults.standard.setValue(idd, forKey: "id")                       
                        
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
    
    
    func zonainfo(zona: String) -> String {
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
        if zona == "12" { zonaf = "Tunja" }
        if zona == "13" { zonaf = "La Flor" }
        if zona == "27" { zonaf = "Pipiral" }
        return zonaf!
    }
    
    func cargarimagen(img : String) {
    let url = URL(string: "http://appholcim.com/img_perfil/\(img)")
    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async() {    // execute on main thread
            self.imagenperfil.image = UIImage(data: data)
          //  self.imagenperfil.layer.cornerRadius = self.imagenperfil.bounds.size.width / 4.0
        }
    }
    task.resume()
    }
    
    
}

