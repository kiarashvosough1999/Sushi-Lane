//
//  FetchVideoAssetsRespositoryProtocol.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/13/23.
//

protocol FetchVideoAssetsRespositoryProtocol {
    func fetch() async throws -> [VideoAssetEntity]
}
