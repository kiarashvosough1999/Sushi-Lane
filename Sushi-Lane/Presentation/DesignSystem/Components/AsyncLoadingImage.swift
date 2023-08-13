//
//  AsyncLoadingImage.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation
import SwiftUI
import Factory

struct AsyncLoadingImage<P>: View where P: View {
    
    private let url: URL
    private let width: CGFloat?
    private let height: CGFloat?
    private let padding: CGFloat
    private let placeHolderImage: () -> P
    
    init(
        url: URL,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        padding: CGFloat = 0,
        placeHolderImage: @escaping () -> P
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.padding = padding
        self.placeHolderImage = placeHolderImage
    }
    
    @Injected(\.imageCache) private var imageCache

    var body: some View {
        if let image = imageCache.image(for: url) {
            image
                .resizable()
                .renderingMode(.original)
                .loadingImage(width: width, height: height, padding: padding)
        } else {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .tint(.white)
                        .progressViewStyle(.circular)
                        .animation(.spring(), value: phase.image)
                        .frame(width: width, height: height, alignment: .center)
                        .padding(.all, padding)
                case .success(let image):
                    successImage(image: image)
                default:
                    placeHolderImage()
                        .loadingImage(width: width, height: height, padding: padding)
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
            .loadingImage(width: width, height: height, padding: padding)
            .animation(.spring(), value: image)
    }
}

extension AsyncLoadingImage: Equatable {
    static func == (lhs: AsyncLoadingImage<P>, rhs: AsyncLoadingImage<P>) -> Bool {
        lhs.url == rhs.url &&
        lhs.width == rhs.width &&
        lhs.height == rhs.height &&
        lhs.padding == rhs.padding
    }
}
