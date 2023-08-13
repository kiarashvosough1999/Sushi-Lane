//
//  ImageCacheProtocol.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/9/23.
//

import SwiftUI

protocol ImageCacheProtocol {
    func image(for url: URL) -> Image?
    func cache(image: Image, for url: URL)
    func resetCache()
}
