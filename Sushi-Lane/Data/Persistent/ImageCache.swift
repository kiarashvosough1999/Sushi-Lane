//
//  ImageCache.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/13/23.
//

import SwiftUI

final class ImageCache {
    private var cache: [URL: Image] = [:]
}

extension ImageCache: ImageCacheProtocol {
    
    func image(for url: URL) -> Image? {
        cache[url]
    }

    func cache(image: Image, for url: URL) {
        cache[url] = image
    }

    func resetCache() {
        cache.removeAll()
    }
}
