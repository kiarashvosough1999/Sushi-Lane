//
//  FetchVideoAssetsUseCaseProtocol.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation

protocol FetchVideoAssetsUseCaseProtocol {
    func fetch() async throws -> [VideoAssetEntity]
}
