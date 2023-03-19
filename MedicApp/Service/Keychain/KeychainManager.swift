//
//  KeychainManager.swift
//  MedicApp
//
//  Created by Павел Кай on 15.03.2023.
//

import Foundation
import Security

protocol KeychainManagerProtocol {
    func add(key: String, data: Data) throws
    func get(key: String) -> Data?
    func delete(key: String) throws
}

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
