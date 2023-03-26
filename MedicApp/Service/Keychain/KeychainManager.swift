//
//  KeychainManager.swift
//  MedicApp
//
//  Created by Павел Кай on 15.03.2023.
//

import Foundation
import Security

/// Безопасное хранение с помощью шифрования
class KeychainManager {
    
    static var email = ""
    
    
    static let `default` = KeychainManager()
    
    enum keys {
        static let token = "\(email)-tokenKey"
        
        static let emailkey = "\(email)-emailkey"
        static let passwordKey = "\(email)-passwordKey"
        static let nameKey = "\(email)-nameKey"
        static let secondKey = "\(email)-secondKey"
        static let surnameKey = "\(email)-surnameKey"
        static let birthKey = "\(email)-birthKey"
        static let sexKey = "\(email)-sexKey"
        
        static let adresskey = "\(email)-adresskey"
        static let dolgotaKey = "\(email)-dolgotaKey"
        static let shirotaKey = "\(email)-shirotaKey"
        static let visotaKey = "\(email)-visotaKey"
        static let flatKey = "\(email)-flatKey"
        static let podezdKey = "\(email)-podezdKey"
        static let etajKey = "\(email)-etajKey"
        static let domofonKey = "\(email)-domofonKey"
        static let nameAdressKey = "\(email)-nameAdressKey"
    }
 
    
    
}
