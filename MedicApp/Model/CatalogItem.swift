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
    let price: String
    let category: String
    let time_result: String
    let preparation: String
    let bio: String
}
