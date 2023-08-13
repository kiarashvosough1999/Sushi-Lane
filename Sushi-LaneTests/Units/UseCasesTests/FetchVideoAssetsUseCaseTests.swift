//
//  FetchVideoAssetsUseCaseTests.swift
//  Sushi-LaneTests
//
//  Created by Kiarash Vosough on 8/9/23.
//

import XCTest
import Factory
@testable import Sushi_Lane

final class FetchVideoAssetsUseCaseTests: XCTestCase, JSONLoader {

    private var sut: FetchVideoAssetsUseCaseProtocol!
    private var assets: [VideoAssetEntity]!
    
    override func setUpWithError() throws {
        assets = try videoAssets()
        
        let fetchVideoAssetsStub = FetchVideoAssetsStub(
            delayInSeconds: 1,
            assets: assets
        )

        Container.shared.fetchVideoAssetsRespository.register { fetchVideoAssetsStub }
        sut = Container.shared.fetchVideoAssetsUseCase.resolve()
    }

    override func tearDownWithError() throws {
        sut = nil
        Container.shared.reset()
    }

    func testFetchVideo() async throws {
        let fetchedAssets = try await sut.fetch()
        XCTAssertEqual(
            assets.map(\.tvShow),
            fetchedAssets.map(\.tvShow)
        )

        XCTAssertEqual(
            assets.map(\.titleDefault),
            fetchedAssets.map(\.titleDefault)
        )
    }

    func testLoadVideoImageURL() async throws {
        let profilePath = "profile:7tv-868x488"
        
        let fetchedAssets = try await sut.fetch()
        
        fetchedAssets.forEach { asset in
            XCTAssertEqual(asset.imageURL.lastPathComponent, "wm:\(asset.tvShow.channelId)")
            XCTAssertEqual(asset.imageURL.deletingLastPathComponent().lastPathComponent, profilePath)
        }
    }
}
