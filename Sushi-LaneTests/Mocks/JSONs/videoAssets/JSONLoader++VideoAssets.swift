//
//  JSONLoader++VideoAssets.swift
//  Sushi-LaneTests
//
//  Created by Kiarash Vosough on 8/8/23.
//

@testable import Sushi_Lane

extension JSONLoader {
    
    func videoAssets() throws -> [VideoAssetEntity] {
        try loadJSON(name: "videoAssets", as: [VideoAssetEntity].self)
    }
}
