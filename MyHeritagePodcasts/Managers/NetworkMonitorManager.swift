//
//  NetworkMonitorManager.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import Network

class NetworkMonitorManager {
    static let shared = NetworkMonitorManager()
    
    private let monitor = NWPathMonitor()
    var status = NWPath.Status.requiresConnection
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
        }
        let queue = DispatchQueue(label: "MyHeritageNetworkMonitorQueue")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
