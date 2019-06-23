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
    
    let plantas = ["Bello","Buga","Cali Sur","Cemento","Chía" ,"Floridablanca","Nobsa","Palmira","Puente Aranda","Ricaurte","Teleport","Tunja","La Flor","Pipiral"]
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        piker.isHidden = true
        imagePicker.delegate = self
       
    }

    
    @IBAction func oultar(_ sender: Any) {
        piker.isHidden = true
    }
    
    @IBAction func mostrarlista(_ sender: Any) {
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
                
        let parameters = ["nombre":nombrer, "apellidos":apellidosr, "zona":zonar, "area":cargosr,"email":emailr,"password":passwordr,"codempleado":codr]
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
