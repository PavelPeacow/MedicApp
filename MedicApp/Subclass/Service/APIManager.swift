//
//  APIManager.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import Foundation

enum APIError: Error {
    case noFile
    case canNotGet
    case canNotDecode
}

class APIManager {
    
    let jsonDecoder: JSONDecoder
    let urlSecssion: URLSession
    
    init(jsonDecoder: JSONDecoder = .init(), urlSecssion: URLSession = .shared) {
        self.jsonDecoder = jsonDecoder
        self.urlSecssion = urlSecssion
    }
    
    func makeAPICall<T: Codable>(type: T.Type) throws -> T {
        
        guard let file = Bundle.main.url(forResource: "NewsMock", withExtension: "json") else { throw APIError.noFile }
        
        guard let data = try? Data(contentsOf: file) else { throw APIError.canNotGet }
        
        guard let data = try? jsonDecoder.decode(T.self, from: data) else { throw APIError.canNotDecode }
        
        return data
    }
    
}
