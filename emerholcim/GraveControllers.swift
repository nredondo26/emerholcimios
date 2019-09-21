//
//  GraveControllers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/1/19.
//

import UIKit

class GraveController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        
        teams = ["Paro Cardio-respiratorio(RCP)","Perdida del Estado de la Conciencia","Electrocucíon","Asfixia  / Atragantamiento","Trauma Cráneo-encefálico","Trauma Torácico","Trauma  de Columna","Trauma Térmico","Herídas y Fractras"]
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let idseleccionado = indexPath.row
        self.performSegue(withIdentifier: "levelunog", sender: idseleccionado)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "levelunog"){
            let idseleccionadorecibido = sender as! Int
            let objleveluno : GraveunoController = segue.destination as! GraveunoController
            objleveluno.datorecibido = teams[idseleccionadorecibido]
            
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    
}

