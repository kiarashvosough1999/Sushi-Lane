//
//  SushiLaneViewModelIntegratedTests.swift
//  Sushi-LaneTests
//
//  Created by Kiarash Vosough on 8/13/23.
//

import XCTest
import Factory
@testable import Sushi_Lane

final class SushiLaneViewModelIntegratedTests: XCTestCase, JSONLoader {

    private var sut: SushiLaneViewModel!
    private var assets: [VideoAssetEntity]!
    
    override func setUpWithError() throws {
        assets = try videoAssets()
        let fetchVideoAssetsStub = FetchVideoAssetsStub(
            delayInSeconds: 1,
            assets: assets
        )

        Container.shared.fetchVideoAssetsRespository.register { fetchVideoAssetsStub }
        sut = SushiLaneViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        Container.shared.reset()
    }

    func testLoadVideoAssetLoadingSuccessfully() async throws {


        await sut.loadVideoAssets()

        if case let .loaded(viewModels) = sut.state {
            XCTAssertEqual(
                assets.map(\.tvShow),
                viewModels.map(\.videoAsset.tvShow)
            )

            XCTAssertEqual(
                assets.map(\.titleDefault),
                viewModels.map(\.videoAsset.titleDefault)
            )
        } else {
            XCTFail()
        }
    }

    func testImageURL() async throws {
        let profilePath = "profile:7tv-868x488"
        let assets = try videoAssets()

        let fetchVideoAssetsStub = FetchVideoAssetsStub(
            delayInSeconds: 1,
            assets: assets
        )

        Container.shared.fetchVideoAssetsRespository.register { fetchVideoAssetsStub }

        await sut.loadVideoAssets()

        if case let .loaded(viewModels) = sut.state {
            viewModels.forEach { asset in
                XCTAssertEqual(
                    asset.videoAsset.imageURL.lastPathComponent,
                    "wm:\(asset.videoAsset.tvShow.channelId)"
                )
                XCTAssertEqual(
                    asset.videoAsset.imageURL.deletingLastPathComponent().lastPathComponent,
                    profilePath
                )
            }
        } else {
            XCTFail()
        }
    }
}
