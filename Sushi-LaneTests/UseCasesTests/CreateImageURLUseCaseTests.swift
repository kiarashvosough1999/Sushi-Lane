//
//  CreateImageURLUseCaseTests.swift
//  Sushi-LaneTests
//
//  Created by Kiarash Vosough on 8/9/23.
//

import XCTest
@testable import Sushi_Lane

final class CreateImageURLUseCaseTests: XCTestCase, JSONLoader {

    private var sut: CreateImageURLUseCaseProtocol!
    
    override func setUpWithError() throws {
        sut = CreateImageURLUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCreatingImageURL() throws {
        let videoAsset = try videoAssets().first!
        
        let imageURL = try sut.createURL(for: videoAsset)
        
        XCTAssertEqual(
            imageURL,
            URL(string: videoAsset.imageURL + "/profile:7tv-868x488/wm:\(videoAsset.tvShow.channelId)")
        )
    }
}
