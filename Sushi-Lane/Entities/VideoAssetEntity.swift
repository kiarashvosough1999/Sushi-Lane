//
//  VideoAssetEntity.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation

struct VideoAssetEntity {
    let imageURL: String
    let titleDefault: String
    let tvShow: TVShowEntity
}

extension VideoAssetEntity: Decodable {}
