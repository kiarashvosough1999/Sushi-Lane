//
//  FirstAppearModifier.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/11/23.
//

import SwiftUI

extension View {
    func onFirstAppear(_ action: @escaping () async -> Void) -> some View {
        modifier(FirstAppearModifier(action: action))
    }
}

private struct FirstAppearModifier: ViewModifier {

    private let action: () async -> ()

    init(action: @escaping () async -> Void) {
        self.action = action
    }

    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            Task {
                await action()
            }
        }
    }
}
