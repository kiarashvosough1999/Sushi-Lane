//
//  AsyncLoadingImage.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation
import SwiftUI

struct AsyncLoadingImage: View {
    
    private let url: URL
    private let width: CGFloat?
    private let height: CGFloat?
    private let padding: CGFloat
    
    init(url: URL, width: CGFloat? = nil, height: CGFloat? = nil, padding: CGFloat = 0) {
        self.url = url
        self.width = width
        self.height = height
        self.padding = padding
    }

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
                    .animation(.spring(), value: phase.image)
                    .frame(width: width, height: height, alignment: .center)
                    .padding(.all, padding)
            case .success(let image):
                image
                    .resizable()
                    .renderingMode(.original)
                    .loadingImage(width: width, height: height, padding: padding)
                    .animation(.spring(), value: phase.image)
            default:
                Image("no_image_high_res")
                    .resizable()
                    .renderingMode(.original)
                    .loadingImage(width: width, height: height, padding: padding)
                    .animation(.spring(), value: phase.image)
            }
        }
    }
}
