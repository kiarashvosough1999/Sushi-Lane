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
        .scope(.singleton)
    }
    
    var fetchVideoAssetsUseCase: Factory<FetchVideoAssetsUseCaseProtocol> {
        Factory(self) { self.network() }
    }
}
