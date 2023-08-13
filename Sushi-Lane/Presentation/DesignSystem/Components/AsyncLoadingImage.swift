//
//  AsyncLoadingImage.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation
import SwiftUI
import Factory

struct AsyncLoadingImage: View {
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    @Injected(\.imageCache) private var imageCache

    var body: some View {
        if let image = imageCache.image(for: url) {
            image
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
        } else {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .tint(.white)
                        .progressViewStyle(.circular)
                        .animation(.spring(), value: phase.image)
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .center)
                case .success(let image):
                    successImage(image: image)
                default:
                    Image("no_image_high_res")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .animation(.spring(), value: phase.image)
                }
            }
        }
    }

    private func successImage(image: Image) -> some View {
        imageCache.cache(image: image, for: url)
        return image
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .animation(.spring(), value: image)
    }
}

extension AsyncLoadingImage: Equatable {
    static func == (lhs: AsyncLoadingImage, rhs: AsyncLoadingImage) -> Bool {
        lhs.url == rhs.url
    }
}
