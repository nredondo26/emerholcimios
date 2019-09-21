//
//  ToxiControllers.swift
//  emerholcim
//
//  Created by nerb2019 on 6/1/19.
//

import UIKit

class ToxiController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        
        teams = ["Eventos Vascular Cerebal","Síndrome Ortostatico","Dolor Precordial","Estado Mental Alterado","Convulsiones o Epilepsia","Crisis Hipertensiva/Migraña","Sangrado Nasal/Epistaxis","Embrazo de Riesgo"]
        // Do any additional setup after loading the view.
    }
    
    
}
