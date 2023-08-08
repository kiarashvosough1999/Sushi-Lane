//
//  NetworkServices+FetchVideoAssetsUseCaseProtocol.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import KNetworking

extension NetworkServices: FetchVideoAssetsUseCaseProtocol {
    
    func fetch() async throws -> [VideoAssetEntity] {
        let result = try await session.data(for: Request())
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }
        return try result.decode(to: [VideoAssetEntity].self)
    }
}

// Requests

fileprivate struct Request {}

extension Request: API {

    var method: HTTPMethod {
        .get
    }
    
    var gateway: GateWaysProtocol {
        NetworkServices.Gayways.base
    }
    
    var route: String {
        "popular/videos"
    }
}
