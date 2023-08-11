//
//  SushiLaneViewModelTests.swift
//  Sushi-LaneTests
//
//  Created by Kiarash Vosough on 8/11/23.
//

import XCTest
import Factory
@testable import Sushi_Lane

final class SushiLaneViewModelTests: XCTestCase, JSONLoader {

    private var sut: SushiLaneViewModel!
    
    override func setUpWithError() throws {
        sut = SushiLaneViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInitialState() throws {
        XCTAssertEqual(sut.state, .notLoaded)
    }

    func testLoadVideoAssetLoadingState() throws {
        let fetchVideoAssetUseCase = FetchVideoAssetsUseCaseStub(delayInSeconds: 60, assets: [])

        Container.shared.fetchVideoAssetsUseCase.register { fetchVideoAssetUseCase }
        
        Task {
            await sut.loadVideoAssets()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.sut.state, .loading)
        }
    }

    func testLoadVideoAssetLoadingSuccessfully() async throws {
        let assets = try videoAssets()
        let viewModels: [VideoAssetViewModel] = assets.map { entity in
            VideoAssetViewModel(videoAsset: entity, focused: false)
        }
        
        let fetchVideoAssetUseCase = FetchVideoAssetsUseCaseStub(
            delayInSeconds: 1,
            assets: assets
        )

        Container.shared.fetchVideoAssetsUseCase.register { fetchVideoAssetUseCase }
        
        await sut.loadVideoAssets()
        
        XCTAssertEqual(
            self.sut.state,
            .loaded(viewModels)
        )
    }

    func testLoadVideoAssetLoadingFailed() async throws {
        let error = NSError()
        
        let fetchVideoAssetUseCase = FetchVideoAssetsUseCaseStub(
            error: error,
            delayInSeconds: 1
        )

        Container.shared.fetchVideoAssetsUseCase.register { fetchVideoAssetUseCase }
        
        await sut.loadVideoAssets()
        
        XCTAssertEqual(
            self.sut.state,
            .failedToLoad(message: "Try Again")
        )
    }

    func testLoadVideoImageURL() async throws {
        let url = URL(string: "https://www.google.com")
        let assets = try videoAssets()
        
        let fetchVideoAssetUseCase = FetchVideoAssetsUseCaseStub(
            delayInSeconds: 1,
            assets: assets
        )
        let createImageURLUseCase = CreateImageURLUseCaseStub(url: url)

        Container.shared.createImageURLUseCase.register { createImageURLUseCase }
        Container.shared.fetchVideoAssetsUseCase.register { fetchVideoAssetUseCase }
        
        await sut.loadVideoAssets()
        
        if case let .loaded(viewModels) = sut.state {
            XCTAssertFalse(viewModels.isEmpty)
            viewModels.forEach { asset in
                XCTAssertEqual(asset.imageURL, url)
            }
        } else {
            XCTFail()
        }
    }

    func testLoadVideoImageURLIntegrated() async throws {
        let profilePath = "profile:7tv-868x488"
        let assets = try videoAssets()
        
        let fetchVideoAssetUseCase = FetchVideoAssetsUseCaseStub(
            delayInSeconds: 1,
            assets: assets
        )

        Container.shared.fetchVideoAssetsUseCase.register { fetchVideoAssetUseCase }
        
        await sut.loadVideoAssets()
        
        if case .loaded(let viewModels) = sut.state {
            viewModels.forEach { asset in
                XCTAssertEqual(asset.imageURL?.lastPathComponent, "wm:\(asset.videoAsset.tvShow.channelId)")
                XCTAssertEqual(asset.imageURL?.deletingLastPathComponent().lastPathComponent, profilePath)
            }
        } else {
            XCTFail()
        }
    }
}
