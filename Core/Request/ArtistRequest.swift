//
//  ArtistRequest.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 20/06/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import Foundation
import LDNetwork
    
final class ArtistSearchRequest: APIRequest {
    typealias Response = GetSearchArtistResponse
    
    var queryItems: [URLQueryItem] = []
    
    var ressource: String {
        return "search/artist"
    }
    
    init(artist: String, limit: Int = 100) {
        let queryItem = URLQueryItem(name: "q", value: artist)
        let limitItem = URLQueryItem(name: "limit", value: "\(limit)")
        
        queryItems.append(queryItem)
        queryItems.append(limitItem)
    }
}
