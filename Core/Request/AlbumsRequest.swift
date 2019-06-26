//
//  AlbumRequest.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 30/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import LDNetwork

struct AlbumRequest: APIRequest {
    typealias Response = GetAlbumResponse

    var queryItems: [URLQueryItem] = []
    var ressource: String {
        return "/artist/\(artistId)/albums"
    }

    //Parameters
    private let artistId: Int

    init(artistId: Int,
         limit: Int = 100) {
        self.artistId = artistId
        let limitItem = URLQueryItem(name: "limit", value: "\(limit)")
        queryItems.append(limitItem)
    }
}
