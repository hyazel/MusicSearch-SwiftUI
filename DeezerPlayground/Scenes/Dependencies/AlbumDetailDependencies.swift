//
//  File.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 30/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import Core
import LDNetwork

struct AlbumDetailDependencies {
    let searchDataController: SearchDataControlleable
    let artistId: Int
}

func buildAlbumDetailDependencies(albumId: Int) -> AlbumDetailDependencies {
    let searchDataController: SearchDataControlleable = SearchDataController(client: APIClient(url: URL(string:"http://api.deezer.com/")!))
    
    return AlbumDetailDependencies(searchDataController: searchDataController, artistId: albumId)
}

func buildMockAlbumDetailDependencies(mockType: MockSearchDataController.MockType) -> AlbumDetailDependencies {
    let searchDataController: SearchDataControlleable = MockSearchDataController(mockType: mockType)
    return AlbumDetailDependencies(searchDataController: searchDataController, artistId: 10)
}
