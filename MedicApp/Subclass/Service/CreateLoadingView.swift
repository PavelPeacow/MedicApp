//
//  CreateLoadingView.swift
//  MedicApp
//
//  Created by Павел Кай on 28.03.2023.
//

import UIKit

extension UIViewController {
    
    func createLoadingView() -> UIActivityIndicatorView {
        let loadingView = UIActivityIndicatorView(style: .large)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        return loadingView
    }
    
}
