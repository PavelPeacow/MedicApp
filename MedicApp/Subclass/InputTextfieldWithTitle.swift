//
//  InputTextfieldWithTitle.swift
//  MedicApp
//
//  Created by Павел Кай on 21.03.2023.
//

import UIKit

class InputTextfieldWithTitle: UIView {
 
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, textfield])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var textfield = InputTextfield()
    
    init(title: String? = nil, placeholder: String? = nil) {
        super.init(frame: .zero)
        
        label.text = title
        textfield.placeholder = placeholder
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textfield.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
