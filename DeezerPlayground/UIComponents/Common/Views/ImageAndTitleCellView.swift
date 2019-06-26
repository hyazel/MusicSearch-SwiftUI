//
//  ImageAndTitleCellView.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 24/06/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import SwiftUI

struct ImageAndTitleCellView<Model>: View {
    let model: Model
    let cellConfigurator: CellConfiguratorTitleImage<Model>
    
    var body: some View {
        HStack(spacing: 40) {
            RemoteImage(url: model[keyPath: cellConfigurator.imageUrlKeyPath])
            Text(model[keyPath: cellConfigurator.titleKeyPath])
            }.padding()
    }
}

struct RemoteImage: View {
    var dataStore = ImageService()
    
    let url: URL?
    @State var image: UIImage?
    
    var body: some View {
        Image(uiImage: self.image ?? UIImage(imageLiteralResourceName: "dog"))
            .resizable()
            .onAppear {
                guard let url = self.url else { return }
                self.dataStore.getImage(withURL: url) { (image) in
                    self.image = image
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .cornerRadius(50.0)
            .shadow(radius: 10)
        //.modifier(ImageModifierRound())
    }
}

#if DEBUG
struct ImageAndTitleCellView_Previews : PreviewProvider {
    static var previews: some View {
        ImageAndTitleCellView(model: ArtistCellViewModel(title: "dog", image: nil, id: 1), cellConfigurator: CellConfiguratorTitleImage<ArtistCellViewModel>(titleKeyPath: \.title, imageUrlKeyPath: \.image))
    }
}
#endif
