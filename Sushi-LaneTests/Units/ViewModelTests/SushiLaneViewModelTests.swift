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
        Container.shared.reset()
    }

    func testInitialState() throws {
        XCTAssertEqual(sut.state, .notLoaded)
    }

    func testLoadVideoAssetLoadingState() async throws {
        let fetchVideoAssetsStub = FetchVideoAssetsStub(delayInSeconds: 10, assets: [])

        Container.shared.fetchVideoAssetsUseCase.register { fetchVideoAssetsStub }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertEqual(self.sut.state, .loading)
        }
        await sut.loadVideoAssets()
    }

    func testLoadVideoAssetLoadingSuccessfully() async throws {
        let assets = try videoAssets()
        let viewModels: [VideoAssetViewModel] = assets.map { entity in
            VideoAssetViewModel(videoAsset: entity, focused: false)
        }
        
        let fetchVideoAssetsStub = FetchVideoAssetsStub(
            delayInSeconds: 1,
            assets: assets
        )

        Container.shared.fetchVideoAssetsUseCase.register { fetchVideoAssetsStub }
        
        await sut.loadVideoAssets()
        
        XCTAssertEqual(
            sut.state,
            .loaded(viewModels)
        )
    }

    func testLoadVideoAssetLoadingFailed() async throws {
        let error = NSError()
        
        let fetchVideoAssetsStub = FetchVideoAssetsStub(
            error: error,
            delayInSeconds: 1
        )

        Container.shared.fetchVideoAssetsUseCase.register { fetchVideoAssetsStub }
        
        await sut.loadVideoAssets()
        
        XCTAssertEqual(
            sut.state,
            .failedToLoad(message: "Try Again")
        )
    }
}
