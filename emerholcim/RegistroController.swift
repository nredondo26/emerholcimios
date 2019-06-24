//
//  RegistroController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/6/19.
//

import UIKit
import Alamofire


class RegistroController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var zona: UITextField!
    @IBOutlet weak var cargos: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var codempleado: UITextField!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var piker: UIPickerView!
    
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
    
   /* let listacargos = ["Cargos",
                  "Jefe de Brigada",
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
                  "Trabajador no Holcim"]*/
    
    var estadopiker : Int = 0
    
    var valor: String?
    var valorr: Int?
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        piker.isHidden = true
        imagePicker.delegate = self
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
    
    @IBAction func oultar(_ sender: Any) {
        estadopiker = 0
        piker.isHidden = true
    }
    
    @IBAction func mostrarlista(_ sender: Any) {
        estadopiker = 1
        piker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return plantas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plantas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
      zona.text = plantas[row]

    }

    @IBAction func cargarimagen(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
                
        let parameters = ["nombre":nombrer, "apellidos":apellidosr, "zona":valorzona, "area":cargosr,"email":emailr,"password":passwordr,"codempleado":codr]
        let imageToUploadURL = Bundle.main.url(forResource: "30601611", withExtension: "jpeg")
        let url = "http://appholcim.com/registro.php"
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageToUploadURL!, withName: "imagen")
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                }
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let jsonResponse = response.result.value as? [String: Any] {
                            print(jsonResponse)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
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
