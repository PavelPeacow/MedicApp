//
//  InternetAlert.swift
//  MedicApp
//
//  Created by Павел Кай on 26.03.2023.
//

import UIKit

extension UIViewController {
    
    func showInternetConnectionProblemAlert() {
        let ac = UIAlertController(title: "Интернет пропал!", message: "Печаль!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK!", style: .default))
        DispatchQueue.main.async {
            self.present(ac, animated: true)
        }
    }
    
}
