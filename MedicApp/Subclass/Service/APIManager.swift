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

enum Endpoint {
    
    case sendCode(email: String)
    case signIn(email: String, code: String)
    
    case catalog
    case news
    
    var url: URL? {
        switch self {
        case .sendCode:
            return .init(string: "https://medic.madskill.ru/api/sendCode")
        case .signIn:
            return .init(string: "https://medic.madskill.ru/api/signin")
        case .catalog:
            return .init(string: "https://medic.madskill.ru/api/catalog")
        case .news:
            return.init(string: "https://medic.madskill.ru/api/news")
        }
    }
    
    var httpMethod: String {
        switch self {
        case .sendCode, .signIn:
            return "POST"
        case .catalog, .news:
            return "GET"
        }
    }
    
    func requset() -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        switch self {
        case .sendCode(let email):
            request.setValue(email, forHTTPHeaderField: "email")
            return request
        case .signIn(let email, let code):
            request.setValue(email, forHTTPHeaderField: "email")
            request.setValue(code, forHTTPHeaderField: "code")
            return request
        case .catalog:
            return request
        case .news:
            return request
        }
    }
    
}

class APIManager {
    
    let jsonDecoder: JSONDecoder
    let urlSecssion: URLSession
    
    init(jsonDecoder: JSONDecoder = .init(), urlSecssion: URLSession = .shared) {
        self.jsonDecoder = jsonDecoder
        self.urlSecssion = urlSecssion
    }
    
    func makeAPICall<T: Codable>(type: T.Type, endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.requset() else { throw APIError.noFile }
        
        guard let (data, _) = try? await urlSecssion.data(for: request) else { throw APIError.canNotGet }
        
        guard let result = try? jsonDecoder.decode(T.self, from: data) else { throw APIError.canNotDecode }
        
        return result
    }
    
}
