//
//  FetchVideoAssetsUseCaseProtocol.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Factory
import Foundation

/// did not implement standalone structure, because it contains no logic
/// instead it was implemented directly on data layer
protocol FetchVideoAssetsUseCaseProtocol {
    func fetch() async throws -> [VideoAssetEntity]
}

struct FetchVideoAssetsUseCase {
    @Injected(\.fetchVideoAssetsRespository) private var fetchVideoAssetsRespository
}

extension FetchVideoAssetsUseCase: FetchVideoAssetsUseCaseProtocol {

    func fetch() async throws -> [VideoAssetEntity] {
        let assets = try await fetchVideoAssetsRespository.fetch()
        
        return assets.map { asset in
            var initialURL = asset.imageURL
            initialURL.append(components: "profile:7tv-868x488", "wm:\(asset.tvShow.channelId)")
            var newAsset = asset
            newAsset.imageURL = initialURL
            return newAsset
        }
    }
}
