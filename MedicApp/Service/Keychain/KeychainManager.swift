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
    
//    func saveAdress(adress: String, dolgota: String, shirota: String,
//                    visota: String, flat: String, podezd: String,
//                    etaj: String, domofon: String, nameAdress: String) {
//        
//        add(key: KeychainManager.keys.adresskey, data: adress.data(using: .utf8)!)
//        add(key: KeychainManager.keys.dolgotaKey, data: dolgota.data(using: .utf8)!)
//        add(key: KeychainManager.keys.shirotaKey, data: shirota.data(using: .utf8)!)
//        add(key: KeychainManager.keys.visotaKey, data: visota.data(using: .utf8)!)
//        add(key: KeychainManager.keys.flatKey, data: flat.data(using: .utf8)!)
//        add(key: KeychainManager.keys.podezdKey, data: podezd.data(using: .utf8)!)
//        add(key: KeychainManager.keys.etajKey, data: etaj.data(using: .utf8)!)
//        add(key: KeychainManager.keys.domofonKey, data: domofon.data(using: .utf8)!)
//        add(key: KeychainManager.keys.nameAdressKey, data: nameAdress.data(using: .utf8)!)
//        
//    }
    
 
    
    
}
