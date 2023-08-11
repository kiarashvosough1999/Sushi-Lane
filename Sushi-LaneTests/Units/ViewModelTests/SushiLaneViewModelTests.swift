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
}
