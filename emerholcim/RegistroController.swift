//
//  RegistroController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/6/19.
//

import UIKit
import Alamofire
import Toaster
import Toast_Swift
import iOSDropDown

class RegistroController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    
    
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var zona: DropDown!
    @IBOutlet weak var cargos: DropDown!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var codempleado: UITextField!
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var vistazona: UIView!
    
    
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
        
        zona.optionArray = plantas
        cargos.optionArray = listacargos
       
        imagePicker.delegate = self
        
        //frapmento para ocultar teclado parte 1
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegistroController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // fin fragmento
    }
    
    //function para ocultar teclado parte 2
    @objc func dismissKeyboard() {
        //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
        view.endEditing(true)
    }
    // fin fragmento
    
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
    

    @IBAction func cargarimagen(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func uploadImage(img: UIImage, nombre: String, apellidos: String, zona: String, cargos: String, email: String, password: String, codigoempleado: String){
        let ImageData = img.jpegData(compressionQuality: 0.8)
        let urlReq = "http://appholcim.com/registro.php"
        
         let parameters = ["nombre":nombre, "apellidos":apellidos, "zona":zona, "area":cargos,"email":email,"password":password,"codempleado":codigoempleado]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(ImageData!, withName: "imagen",fileName: "imagen.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {//this will loop the 'parameters' value, you can comment this if not needed
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
        to:urlReq)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                   // print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                   // print(response.result.value!)
                    if let dic = response.result.value as? NSDictionary{
                        let estado: String = dic["estado"]! as! String
                        if (estado == "exitoso"){
                            self.view.hideToastActivity()
                            Toast(text: "Registro Exitoso").show()
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginp") as! ViewController
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            self.present(newViewController, animated: true, completion: nil)
                        }
                        if (estado == "registrado"){
                            self.view.hideToastActivity()
                            Toast(text: "Usuario ya se encuentra Registrado").show()
                        }
                        if (estado == "Codnot"){
                            self.view.hideToastActivity()
                            Toast(text: "Codigo de empleado no encontrado").show()
                        }
                        
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    @IBAction func registrar(_ sender: Any) {
        
        let nombrer = nombre.text!
        let apellidosr = apellidos.text!
        let zonar = zona.text!
        let cargosr = cargos.text!
        let emailr = email.text!
        let passwordr = password.text!
        let codr = codempleado.text!
        
        if(nombrer == "" || apellidosr == "" || zonar == "" || cargosr == "" || emailr == "" || passwordr == "" || codr == ""){
           print("campos vacios")
            return
        }
        
        let valorzona = zonainfo(zona: zonar)
        
        self.view.makeToastActivity(.center)
     //   print(imagen.image!)
        
        uploadImage(img: imagen.image!, nombre: nombrer, apellidos: apellidosr, zona: valorzona, cargos: cargosr, email: emailr, password: passwordr, codigoempleado: codr)
        
    }
    
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagen.contentMode = .scaleAspectFit
            imagen.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
