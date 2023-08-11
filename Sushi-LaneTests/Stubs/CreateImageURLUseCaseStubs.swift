//
//  CreateImageURLUseCaseStubs.swift
//  Sushi-LaneTests
//
//  Created by Kiarash Vosough on 8/11/23.
//

import Foundation
@testable import Sushi_Lane

final class CreateImageURLUseCaseStub {

    private let error: Error?
    private let delayInSeconds: UInt64
    private let url: URL?
    private(set) var videoAsset: VideoAssetEntity!
    
    init(
        error: Error? = nil,
        delayInSeconds: UInt64 = 0,
        url: URL?
    ) {
        self.error = error
        self.delayInSeconds = delayInSeconds
        self.url = url
    }
}

extension CreateImageURLUseCaseStub: CreateImageURLUseCaseProtocol {

    func createURL(for videoAsset: Sushi_Lane.VideoAssetEntity) throws -> URL {
        self.videoAsset = videoAsset
        Thread.sleep(forTimeInterval: TimeInterval(delayInSeconds))
        if let error { throw error }
        return url!
    }
}
