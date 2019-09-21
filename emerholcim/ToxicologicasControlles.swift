//
//  ToxicologicasControlles.swift
//  emerholcim
//
//  Created by nerb2019 on 6/1/19.
//

import UIKit

class ToxicologicaController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text  = teams[indexPath.row]
        
        return cell
    }
    
    var teams: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teams = ["Congestíon Alcohólica/ Etilismo","Efectos por uso de Drogas","Envenenamiento por Insectos"]
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let idseleccionado = indexPath.row
        self.performSegue(withIdentifier: "levelunot", sender: idseleccionado)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "levelunot"){
            let idseleccionadorecibido = sender as! Int
            let objleveluno : ToxicaunoController = segue.destination as! ToxicaunoController
            objleveluno.datorecibido = teams[idseleccionadorecibido]
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    
}


