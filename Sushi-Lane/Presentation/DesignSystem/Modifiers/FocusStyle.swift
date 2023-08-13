//
//  FocusStyle.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/13/23.
//

import SwiftUI

extension ButtonStyle where Self == FocusedStyle {
    static var focused: FocusedStyle { FocusedStyle() }
}

struct FocusedStyle: ButtonStyle {

    @Environment(\.isFocused) private var focused: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .scaleEffect(focused ? 1 : 0.9)
            .animation(.easeInOut(duration: 0.2), value: focused)
    }
}
