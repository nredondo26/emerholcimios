//
//  PacienteController.swift
//  emerholcim
//
//  Created by nerb2019 on 6/8/19.
//

import UIKit
import Alamofire
import Toaster
import Toast_Swift

class PacienteController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var jefe: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var anotacion: UITextField!
    @IBOutlet weak var img1: UIImageView!
    
    var codigoenfermedad: String?
    
    let imagePickeruno = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickeruno.delegate = self
 
    }
    
    @IBAction func cargaruno(_ sender: Any) {
        imagePickeruno.allowsEditing = false
        imagePickeruno.sourceType = .photoLibrary
        present(imagePickeruno, animated: true, completion: nil)
    }
    
    @IBAction func enviarinformacion(_ sender: Any) {
        registrar()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img1.contentMode = .scaleAspectFit
            img1.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func registrar() {
        
        let txtnombre = nombre.text!
        let txtjefe = jefe.text!
        let txtarea = area.text!
        let txtanotacion = anotacion.text!
        
        if(txtnombre == "" || txtarea == "" || txtjefe == "" || txtanotacion == ""){
            print("campos vacios")
            return
        }
        
        self.view.makeToastActivity(.center)
        
        let codigoempleado = UserDefaults.standard.value(forKey: "id") as! String
        
        uploadImage(img: img1.image!, nombre: txtnombre, jefe: txtjefe, area: txtarea, anotacion: txtanotacion, codempleado: codigoempleado, codenfermendad: codigoenfermedad!)
        
    }
    
    func uploadImage(img: UIImage, nombre: String, jefe: String, area: String, anotacion: String,  codempleado: String, codenfermendad: String){
        
        let ImageData = img.jpegData(compressionQuality: 0.8)
        
        let urlReq = "http://appholcim.com/registropaciente.php"
        
        let parameters = ["nombre":nombre,"area":area,"jefe":jefe,"anotacion":anotacion,"cod":codenfermendad , "idusuario":codempleado]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(ImageData!, withName: "img1",fileName: "img1.jpg", mimeType: "image/jpg")
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
                  //  print(response.result.value!)
                    if let dic = response.result.value as? NSDictionary{
                        let estado: String = dic["estado"]! as! String
                        if (estado == "exitoso"){
                            
                            self.view.hideToastActivity()
                            Toast(text: "Registro Exitoso").show()
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "menu") as! MenuController
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            self.present(newViewController, animated: true, completion: nil)
                            
                        }
                     }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    
}
