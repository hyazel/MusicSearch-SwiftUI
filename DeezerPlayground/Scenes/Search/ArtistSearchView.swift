//
//  ArtistSearchView.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 21/06/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import SwiftUI
import Core
import Combine

struct ArtistSearchView : View {
    @ObjectBinding var viewModel: ArtistSearchViewModel // Injected
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.artistsCellViewModel) { artist in
                    NavigationButton(destination: AlbumDetail(viewModel: AlbumDetailViewModel(dependencies: buildAlbumDetailDependencies(albumId: artist.id)))) {
                        self.buildCell(artist: artist)
                    }
                }
                }
                .onAppear {
                    self.viewModel.searchBarInput = "s"
            }
        }.navigationBarTitle(Text("Artistes").font(Font.largeTitle).color(.black))
    }
    
    func buildCell(artist: ArtistCellViewModel) -> ImageAndTitleCellView<ArtistCellViewModel> {
        let cc = CellConfiguratorTitleImage<ArtistCellViewModel>(
            titleKeyPath: \ArtistCellViewModel.title,
            imageUrlKeyPath: \ArtistCellViewModel.image)
        return ImageAndTitleCellView(model: artist, cellConfigurator: cc)
        
    }
}

#if DEBUG
struct ArtistSearchView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ArtistSearchView(viewModel:
                ArtistSearchViewModel(dependencies:
                    buildMockArtistSearchDependencies(mockType: .artists)))
        }
    }
}
#endif
