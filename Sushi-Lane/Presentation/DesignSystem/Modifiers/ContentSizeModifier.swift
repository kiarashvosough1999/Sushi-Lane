//
//  ContentSizeModifier.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/9/23.
//

import SwiftUI

extension View {
    func contentSize(_ contentSize: Binding<CGSize>) -> some View {
        modifier(ContentSizeModifier(contentSize: contentSize))
    }
}

private struct ContentSizeModifier: ViewModifier {
    @Binding private var contentSize: CGSize
    
    init(contentSize: Binding<CGSize>) {
        self._contentSize = contentSize
    }

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color
                        .clear
                        .onAppear {
                            contentSize = geometry.size
                        }
                }
            )
    }
}
