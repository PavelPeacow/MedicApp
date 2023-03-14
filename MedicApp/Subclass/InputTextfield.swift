//
//  InputTextfield.swift
//  MedicApp
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

class InputTextfield: UITextField {
    
    init(placeholder: String? = nil, keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        leftView = paddingViewLeft
        leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        rightView = paddingViewRight
        rightViewMode = .always
        layer.cornerRadius = 10
        backgroundColor = .systemGray6
        self.keyboardType = keyboardType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
