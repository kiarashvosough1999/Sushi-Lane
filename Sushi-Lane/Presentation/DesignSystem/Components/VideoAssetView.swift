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
            AsyncLoadingImage(url: viewModel.videoAsset.imageURL)
                .equatable()
            title
            Spacer()
            caption
        }
        .background {
            Rectangle()
                .fill(.randomColor)
        }
        .cornerRadius(16)
        .frame(width: width)
    }

    private var title: some View {
        Text(viewModel.videoAsset.tvShow.titleDefault)
            .font(.headline)
            .padding(24)
            .bold()
    }

    private var caption: some View {
        Text(viewModel.videoAsset.titleDefault)
            .font(.caption)
            .padding(24)
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
                )
            ),
            width: 200
        )
    }
}
#endif
