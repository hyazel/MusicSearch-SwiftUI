//
//  ArtistSearchDependencies.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 30/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import Core
import LDNetwork

struct ArtistSearchDependencies {
    let searchDataController: SearchDataControlleable
}

func buildArtistSearchDependencies() -> ArtistSearchDependencies {
    let searchDataController: SearchDataControlleable = SearchDataController(client: APIClient(url: URL(string:"http://api.deezer.com/")!))
    return ArtistSearchDependencies(searchDataController: searchDataController)
}

func buildMockArtistSearchDependencies(mockType: MockSearchDataController.MockType) -> ArtistSearchDependencies {
    let searchDataController: SearchDataControlleable = MockSearchDataController(mockType: mockType)
    return ArtistSearchDependencies(searchDataController: searchDataController)
}
