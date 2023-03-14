//
//  EmailCodeTextfield.swift
//  MedicApp
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

class EmailCodeTextfield: UITextField {

    init() {
        super.init(frame: .zero)
        keyboardType = .numberPad
        backgroundColor = .systemGray6
        textAlignment = .center
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
