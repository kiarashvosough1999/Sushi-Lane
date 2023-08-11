//
//  FetchVideoAssetsUseCaseProtocol.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation

/// did not implement standalone structure, because it contains no logic
/// instead it was implemented directly on data layer
protocol FetchVideoAssetsUseCaseProtocol {
    func fetch() async throws -> [VideoAssetEntity]
}
