//
//  NetworkServices.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation
import KNetworking

final class NetworkServices {

    static let shared = NetworkServices()
    
    private static var cacheMemoryCapacity: Int { Int(1.5e+7) }
    private static var cacheDiskCapacity: Int { Int(1e+8) }
    
    let session: URLSession
    let cache: URLCache
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
        // Use cache if specified on request, specificly for images
        self.cache = URLCache(
            memoryCapacity: NetworkServices.cacheMemoryCapacity,
            diskCapacity: NetworkServices.cacheDiskCapacity
        )
        // Set cache for shared configuration, So that API work with it also use cache.
        session.configuration.urlCache = self.cache
    }
}

extension NetworkServices {
    
    enum Gayways: String, GateWaysProtocol {
        case base = "https://private-f88bc-christianegohring.apiary-mock.com"
    }
}
