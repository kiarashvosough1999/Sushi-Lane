//
//  VideoAssetEntity.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation

struct VideoAssetEntity {
    var imageURL: URL
    let titleDefault: String
    let tvShow: TVShowEntity
}

extension VideoAssetEntity: Decodable {}
extension VideoAssetEntity: Hashable {}
