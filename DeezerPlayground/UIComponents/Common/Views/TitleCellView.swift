//
//  TitleCellViez.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 26/06/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import SwiftUI

struct TitleCellView<Model> : View {
    let model: Model
    let configurator: CellConfiguratorTitle<Model>
    
    var body: some View {
        Text(model[keyPath: configurator.titleKeyPath])
    }
}

#if DEBUG
struct TitleCellView_Previews : PreviewProvider {
    static var previews: some View {
        TitleCellView(model: TrackCellViewModel(title: "mock", previewUrl: ""),
                      configurator: CellConfiguratorTitle<TrackCellViewModel>(titleKeyPath: \.title))
    }
}
#endif
