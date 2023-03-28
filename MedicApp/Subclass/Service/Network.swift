//
//  Network.swift
//  MedicApp
//
//  Created by Павел Кай on 25.03.2023.
//

import Network
import Foundation

class Network {
    
    static let shared = Network()
    
    var monitorInternet = NWPathMonitor(requiredInterfaceType: .wifi)
    
    private let queue = DispatchQueue.global()
    
    init() {
        monitorInternet.start(queue: queue)
       
        
    }
    
    func checkConnection(onChange: @escaping (Bool) -> ()) {
        monitorInternet.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet connection is available.")
                onChange(false)
            } else {
                print("Internet connection is not available.")
                onChange(true)
            }
        }
    }
}
