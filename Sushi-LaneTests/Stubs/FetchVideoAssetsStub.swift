//
//  FetchVideoAssetsStub.swift
//  Sushi-LaneTests
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation
@testable import Sushi_Lane

final class FetchVideoAssetsStub {

    private let error: Error?
    private let delayInSeconds: UInt64
    private let assets: [VideoAssetEntity]
    
    init(
        error: Error? = nil,
        delayInSeconds: UInt64 = 0,
        assets: [VideoAssetEntity] = []
    ) {
        self.error = error
        self.delayInSeconds = delayInSeconds
        self.assets = assets
    }
}

extension FetchVideoAssetsStub: FetchVideoAssetsUseCaseProtocol, FetchVideoAssetsRespositoryProtocol {

    func fetch() async throws -> [VideoAssetEntity] {
        try await Task.sleep(nanoseconds: delayInSeconds * NSEC_PER_SEC)
        if let error { throw error }
        return assets
    }
}
