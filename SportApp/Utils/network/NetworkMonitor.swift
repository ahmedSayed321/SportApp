//
//  NetworkMonitor.swift
//  SportApp
//
//  Created by AndrewMagdy on 08/05/2026.
//

import Foundation
import Network
class NetworkMonitor{
    static let shared = NetworkMonitor()
       private let monitor = NWPathMonitor()
       private let queue = DispatchQueue(label: "NetworkMonitor")
       
       private(set) var isConnected: Bool = false
       
       private init() {
           monitor.pathUpdateHandler = { [weak self] path in
               self?.isConnected = path.status == .satisfied
           }
           monitor.start(queue: queue)
       }
       
       func startMonitoring(onChange: @escaping (Bool) -> Void) {
           monitor.pathUpdateHandler = { [weak self] path in
               let connected = path.status == .satisfied
               self?.isConnected = connected
               DispatchQueue.main.async {
                   onChange(connected)
               }
           }
           monitor.start(queue: queue)
       }
       
       func stopMonitoring() {
           monitor.cancel()
       }
    
}
