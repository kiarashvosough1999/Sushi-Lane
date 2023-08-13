//
//  SushiLaneView.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/9/23.
//

import SwiftUI
import Factory

struct SushiLaneView: View {
    
    @ObservedObject private var viewModel: SushiLaneViewModel

    init(viewModel: SushiLaneViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var contentSize: CGSize = .zero

    var body: some View {
        VStack {
            topTitle
            horizontalList
        }
        .padding()
        .background(.black)
        .animation(.default, value: viewModel.state)
        .onFirstAppear {
            await viewModel.loadVideoAssets()
        }
    }

    private var topTitle: some View {
        Text("Full Episodes")
            .foregroundColor(.white)
            .font(.title2)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var horizontalList: some View {
        WithLoadingState(state: viewModel.state) { dataSource in
            ScrollableLazyHStack(dataSource: dataSource) { item in
                NavigationLink {
                    Text("Detail")
                } label: {
                    VideoAssetView(viewModel: item, width: contentSize.width/2)
                        .equatable()
                        .transition(.scale)
                }
                .buttonStyle(.focused)
            }
        }
        .onRetry {
            await viewModel.loadVideoAssets()
        }
        .contentSize($contentSize)
    }
}

#if DEBUG
struct SushiLaneView_Previews: PreviewProvider {
    static var previews: some View {
        SushiLaneView(viewModel: SushiLaneViewModel())
    }
}
#endif
