//
//  NotFoundView.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/9/23.
//

import SwiftUI

struct NotFoundView: View {

    private let message: String
    private let onRetry: (() async -> Void)?

    init(message: String, onRetry: (() async -> Void)? = nil) {
        self.message = message
        self.onRetry = onRetry
    }

    var body: some View {
        VStack {
            Text(message)
                .font(.title3)
                .bold()
                .foregroundColor(.red )
            if let onRetry {
                Button("Retry", action: { Task(operation: { await onRetry() })})
            }
        }
        .frame(alignment: .center)
    }
}
