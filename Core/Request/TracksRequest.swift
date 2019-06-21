//
//  TracksRequest.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 30/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import LDNetwork

struct TracksRequest: APIRequest {
    typealias Response = GetTrackResponse

    var queryItems: [URLQueryItem] = []
    var ressource: String {
        return "/album/\(albumId)/tracks"
    }

    //Parameters
    private let albumId: Int

    init(albumId: Int,
         limit: Int = 100) {
        self.albumId = albumId
        let limitItem = URLQueryItem(name: "limit", value: "\(limit)")
        queryItems.append(limitItem)
    }
}
