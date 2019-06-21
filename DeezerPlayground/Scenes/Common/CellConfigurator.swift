//
//  CellConfigurator.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 20/06/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import UIKit

struct CellConfiguratorTitleSubtitleImage<Model> {
    let titleKeyPath: KeyPath<Model, String>
    let subtitleKeyPath: KeyPath<Model, String>
    let imageKeyPath: KeyPath<Model, UIImage>
    
    func configure(model: Model) {
        print(model[keyPath: titleKeyPath])
        print(model[keyPath: subtitleKeyPath])
        print(model[keyPath: imageKeyPath])
    }
}

struct CellConfiguratorTitleImage<Model> {
    let titleKeyPath: KeyPath<Model, String>
    let imageKeyPath: KeyPath<Model, UIImage>
    
    func configure(model: Model) {
        print(model[keyPath: titleKeyPath])
        print(model[keyPath: imageKeyPath])
    }
}
