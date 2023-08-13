//
//  NetworkServices+FetchVideoAssetsUseCaseProtocol.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation

extension NetworkServices: FetchVideoAssetsRespositoryProtocol {

    func fetch() async throws -> [VideoAssetEntity] {
        var request = URLRequest(url: URL(string: Gayways.base.rawValue + "/popular/videos")!)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200,
            data.isEmpty == false
        else { throw NSError() }
        return try JSONDecoder().decode([VideoAssetEntity].self, from: data)
    }
}
