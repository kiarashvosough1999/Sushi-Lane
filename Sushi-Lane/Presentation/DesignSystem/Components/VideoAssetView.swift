//
//  VideoAssetView.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/9/23.
//

import SwiftUI
import Factory

// MARK: ViewModel

struct VideoAssetViewModel {
    let videoAsset: VideoAssetEntity
    let focused: Bool
}

extension VideoAssetViewModel: Hashable {}
extension VideoAssetViewModel: Identifiable {
    var id: Int { hashValue }
}

// MARK: - View

struct VideoAssetView: View {

    private let viewModel: VideoAssetViewModel
    private let width: CGFloat

    init(viewModel: VideoAssetViewModel, width: CGFloat) {
        self.viewModel = viewModel
        self.width = width
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncLoadingImage(
                url: viewModel.videoAsset.imageURL,
                width: width,
                height: width/2
            ) {
                placeHolderImage
            }
            .equatable()

            title
        }
        .overlay {
            if viewModel.focused {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.green, lineWidth: 2)
            }
        }
    }
    
    private var placeHolderImage: some View {
        Image("no_image_high_res")
            .resizable()
            .renderingMode(.original)
            .loadingImage(width: width, height: width/2, padding: 0)
    }
    
    private var title: some View {
        Text(viewModel.videoAsset.tvShow.titleDefault)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .font(viewModel.focused ? .title2.bold() : .body)
            .padding(.horizontal, 4)
            .foregroundColor(viewModel.focused ? .green : .white)
    }
}

extension VideoAssetView: Equatable {
    static func == (lhs: VideoAssetView, rhs: VideoAssetView) -> Bool {
        lhs.viewModel == rhs.viewModel &&
        lhs.width == rhs.width
    }
}

#if DEBUG
struct VideoAssetView_Previews: PreviewProvider {
    static var previews: some View {
        VideoAssetView(
            viewModel: VideoAssetViewModel(
                videoAsset: VideoAssetEntity(
                    imageURL: URL.applicationDirectory,
                    titleDefault: "Title",
                    tvShow: TVShowEntity(
                        titleDefault: "Title",
                        channelId: 12
                    )
                ),
                focused: false
            ),
            width: 200
        )
    }
}
#endif
