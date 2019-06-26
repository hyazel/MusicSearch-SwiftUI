//
//  CellConfigurator.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 20/06/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import UIKit
import SwiftUI

struct CellConfiguratorTitleSubtitleImage<Model> {
    let titleKeyPath: KeyPath<Model, String>
    let subtitleKeyPath: KeyPath<Model, String>
    let imageKeyPath: KeyPath<Model, UIImage>
}

struct CellConfiguratorTitleImage<Model> {
    let titleKeyPath: KeyPath<Model, String>
    let imageUrlKeyPath: KeyPath<Model, URL?>
}

struct CellConfiguratorTitle<Model> {
    let titleKeyPath: KeyPath<Model, String>
}
