//
//  CreateImageURLUseCaseProtocol.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/9/23.
//

import Foundation

protocol CreateImageURLUseCaseProtocol {
    func createURL(for videoAsset: VideoAssetEntity) throws -> URL
}

struct CreateImageURLUseCase {}

extension CreateImageURLUseCase: CreateImageURLUseCaseProtocol {

    func createURL(for videoAsset: VideoAssetEntity) throws -> URL {
        guard var initialURL = URL(string: videoAsset.imageURL) else { throw NSError() }
        initialURL.append(components: "profile:7tv-868x488", "wm:\(videoAsset.tvShow.channelId)")
        return initialURL
    }
}
