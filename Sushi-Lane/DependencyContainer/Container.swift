//
//  Container.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Factory

extension Container {

    private var network: Factory<NetworkServices> {
        Factory(self) {
            NetworkServices()
        }
        .scope(.cached)
    }
    
    var imageCache: Factory<ImageCacheProtocol> {
        Factory(self) {
            ImageCache()
        }
        .scope(.cached)
    }
    
    var fetchVideoAssetsUseCase: Factory<FetchVideoAssetsUseCaseProtocol> {
        Factory(self) { FetchVideoAssetsUseCase() }.scope(.graph)
    }
    
    var fetchVideoAssetsRespository: Factory<FetchVideoAssetsRespositoryProtocol> {
        Factory(self) { self.network() }
    }

    var sushiLaneViewModel: Factory<SushiLaneViewModel> {
        Factory(self) { SushiLaneViewModel() }.scope(.shared)
    }
}
