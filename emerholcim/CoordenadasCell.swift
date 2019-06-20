//
//  CoordenadasCell.swift
//  emerholcim
//
//  Created by nerb2019 on 6/15/19.
//

import UIKit

class CoordenadasCell: UITableViewCell {
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var direccion: UILabel!
    var latitud: Double!
    var longitud: Double!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}

