//
//  SushiLaneViewModel.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/9/23.
//

import Foundation
import Factory

final class SushiLaneViewModel: ObservableObject {

    @LazyInjected(\.fetchVideoAssetsUseCase) private var fetchVideoAssetsUseCase
    @LazyInjected(\.imageCache) private var imageCache

    @Published private var _state: LoadingState<[VideoAssetEntity]> = .notLoaded
    @Published private var selectedVideoAsset: VideoAssetEntity?
}

extension SushiLaneViewModel {

    var state: LoadingState<[VideoAssetViewModel]> {
        _state.map { entities in
            entities.map { entity in
                VideoAssetViewModel(videoAsset: entity, focused: selectedVideoAsset == entity)
            }
        }
    }

    @MainActor
    func loadVideoAssets() async {
        _state = .loading
        do {
            let models = try await fetchVideoAssetsUseCase.fetch()
            guard  Task.isCancelled == false else { return }
            self._state = .loaded(models)
        } catch {
            self._state = .failedToLoad(message: "Try Again")
        }
    }

    func didSelectedVideo(_ videoAsset: VideoAssetViewModel) {
        selectedVideoAsset = selectedVideoAsset == videoAsset.videoAsset ? nil : videoAsset.videoAsset
    }
}
