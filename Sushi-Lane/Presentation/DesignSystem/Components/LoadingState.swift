//
//  LoadingState.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/9/23.
//

import SwiftUI

enum LoadingState<T: Equatable>: Equatable {
    case loaded(T)
    case failedToLoad(message: String)
    case notLoaded
    case loading

    func map<S>(_ transform: (T) -> S) -> LoadingState<S> {
        switch self {
        case .loaded(let values):
            return .loaded(transform(values))
        case .failedToLoad(let message):
            return .failedToLoad(message: message)
        case .notLoaded:
            return .notLoaded
        case .loading:
            return .loading
        }
    }
}

struct WithLoadingState<Content, T: Equatable>: View where Content: View {

    private let state: LoadingState<T>
    private let onLoaded: (T) -> Content
    private var onRetry: (() async -> Void)?

    init(
        state: LoadingState<T>,
        @ViewBuilder onLoaded: @escaping (T) -> Content
    ) {
        self.state = state
        self.onLoaded = onLoaded
    }

    var body: some View {
        switch state {
        case .loaded(let values):
            onLoaded(values)
        case .loading:
            Spacer()
            ProgressView()
                .scaleEffect(1.5, anchor: .center)
                .progressViewStyle(.circular)
            Spacer()
        case .failedToLoad(let message):
            Spacer()
            NotFoundView(message: message, onRetry: onRetry)
            Spacer()
        case .notLoaded:
            EmptyView()
        }
    }
}

extension WithLoadingState {

    func onRetry(_ onRetry: @escaping () async -> Void) -> WithLoadingState {
        var mutabelSelf = self
        mutabelSelf.onRetry = onRetry
        return mutabelSelf
    }
}
