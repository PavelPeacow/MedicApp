//
//  CatalogItem.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import Foundation

struct CatalogItem: Codable {
    let id: Int
    let name: String
    let description: String
    var price: String
    let category: String
    let time_result: String
    let preparation: String
    let bio: String
    
    var numberOfPeople: Int? = 1
}

extension CatalogItem {
    
    mutating func changePrice(_ price: Int) {
        self.price = String(price)
    }
    
    mutating func changeNumberOfPeople(_ count: Int) {
        numberOfPeople = count
    }
    
}
