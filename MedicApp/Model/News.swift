//
//  News.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import Foundation

struct News: Codable {
    let id: Int
    let name: String
    let description: String
    let price: String
    let image: String
}
