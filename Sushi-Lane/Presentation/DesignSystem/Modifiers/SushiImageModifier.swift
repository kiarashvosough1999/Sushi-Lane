//
//  LoadingImageModifier.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/11/23.
//

import SwiftUI

extension View {
    func loadingImage(width: CGFloat?, height: CGFloat?, padding: CGFloat) -> some View {
        modifier(LoadingImageModifier(width: width, height: height, padding: padding))
    }
}

private struct LoadingImageModifier: ViewModifier {

    private let width: CGFloat?
    private let height: CGFloat?
    private let padding: CGFloat

    init(width: CGFloat?, height: CGFloat?, padding: CGFloat) {
        self.width = width
        self.height = height
        self.padding = padding
    }

    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: width, maxHeight: height)
            .padding(.all, padding)
            .clipped()
            .cornerRadius(16)
            .shadow(radius: 5)
    }
}
