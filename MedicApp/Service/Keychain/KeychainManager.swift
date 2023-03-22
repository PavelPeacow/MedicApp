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
    
    func saveAdress(adress: String, dolgota: String, shirota: String,
                    visota: String, flat: String, podezd: String,
                    etaj: String, domofon: String, nameAdress: String) {
        
        add(key: KeychainManager.keys.adresskey, data: adress.data(using: .utf8)!)
        add(key: KeychainManager.keys.dolgotaKey, data: dolgota.data(using: .utf8)!)
        add(key: KeychainManager.keys.shirotaKey, data: shirota.data(using: .utf8)!)
        add(key: KeychainManager.keys.visotaKey, data: visota.data(using: .utf8)!)
        add(key: KeychainManager.keys.flatKey, data: flat.data(using: .utf8)!)
        add(key: KeychainManager.keys.podezdKey, data: podezd.data(using: .utf8)!)
        add(key: KeychainManager.keys.etajKey, data: etaj.data(using: .utf8)!)
        add(key: KeychainManager.keys.domofonKey, data: domofon.data(using: .utf8)!)
        add(key: KeychainManager.keys.nameAdressKey, data: nameAdress.data(using: .utf8)!)
        
    }
    
    func add(key: String, data: Data) {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key,
            kSecAttrAccount as String: "pavel.MedicApp.com",
            kSecValueData as String: data
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        guard status != errSecDuplicateItem else {
           print("DuplicateFinded")
            delete(key: key)
            add(key: key, data: data)
            print("Remove Duplicate and save again")
            return
        }
        
        guard status == errSecSuccess else {
            print("SomeError")
            return
        }
        
        print("added")
    }
    
    func get(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key,
            kSecAttrAccount as String: "pavel.MedicApp.com",
            kSecReturnData as String: true
        ] as CFDictionary
        
        var result: AnyObject?
        let _ = SecItemCopyMatching(query, &result)
        
        return result as? Data
    }
    
    func delete(key: String) {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key,
            kSecAttrAccount as String: "pavel.MedicApp.com",
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        
        guard status == errSecSuccess else {
            print("No such item")
            return
        }
        
        print("deleted")
    }
    
    
}
