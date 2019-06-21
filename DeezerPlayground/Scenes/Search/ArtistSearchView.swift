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

struct ArtistCellView: View {
    let model: ArtistCellViewModel
    
    var body: some View {
        HStack {
            RemoteImage(url: model.image)
            
            Text(model.title)
        }
    }
}

struct RemoteImage: View {
    var dataStore = ImageService()
    
    let url: URL?
    @State var image: UIImage?
    
    var body: some View {
        Image(uiImage: self.image ?? UIImage(imageLiteralResourceName: "dog"))
            .onAppear {
                guard let url = self.url else { return }
                self.dataStore.getImage(withURL: url) { (image) in
                    self.image = image
                }
            }
            .relativeSize(width: 100, height: 100)
            .frame(width: 100, height: 100, alignment: .center)
            .clipped()
            .cornerRadius(50.0)
            
            .aspectRatio(contentMode: .fit)
        
        
        
    }
}

struct ArtistSearchView : View {
    @ObjectBinding var viewModel: ArtistSearchViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.artistsCellViewModel) { artist in
                ArtistCellView(model: artist)
            }
            }
            .onAppear {
                self.viewModel.searchBarInput = "korn"
        }
    }
}

#if DEBUG
struct ArtistSearchView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ArtistCellView(model: ArtistCellViewModel(title: "dog", image: nil, id: 1))
            
            ArtistSearchView(viewModel:
                ArtistSearchViewModel(dependencies:
                    buildMockArtistSearchDependencies(mockType: .artists)))
        }
        
    }
}
#endif
