//
//  boton.swift
//  emerholcim
//
//  Created by nerb2019 on 6/19/19.
//

import UIKit

class boton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
}
