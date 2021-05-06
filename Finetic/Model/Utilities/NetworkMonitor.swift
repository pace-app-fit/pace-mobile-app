//
//  NetworkMonitor.swift
//  Finetic
//
//  Created by Tapiwa on 2021-04-28.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "monitor")
    
    var isActive = false
    var isExpensive = false
    var isConstrained = false
    var connectionType = NWInterface.InterfaceType.other
    
    
    
    init() {
        monitor.pathUpdateHandler = { path in
            self.isActive = path.status == .satisfied
            self.isExpensive = path.isExpensive
            self.isConstrained = path.isConstrained

            let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
            self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }

        monitor.start(queue: queue)
    }
}
