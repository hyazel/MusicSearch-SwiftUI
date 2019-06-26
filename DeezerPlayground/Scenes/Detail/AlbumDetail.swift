//
//  ArtistDetail.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 24/06/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import SwiftUI

struct TrackCell: View {
    let model: TrackCellViewModel
    
    var body: some View {
        Text(model.title)
    }
}

struct AlbumDetail : View {
    @ObjectBinding var viewModel: AlbumDetailViewModel
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(viewModel.tracksCellViewModel.identified(by: \.title)) { track in
                    self.buildCell(model: track)
                }
            }
            }
            .navigationBarTitle(Text("Dernier album"))
            .onAppear(perform: {
                self.viewModel.getTracksFromFirstAlbum()
            })
    }

    func buildCell(model: TrackCellViewModel) -> TrackCell {
        return TrackCell(model: model)
    }
}

#if DEBUG
struct AlbumDetail_Previews : PreviewProvider {
    static var previews: some View {
        AlbumDetail(viewModel: AlbumDetailViewModel(dependencies: buildAlbumDetailDependencies(albumId: 0)))
    }
}
#endif
