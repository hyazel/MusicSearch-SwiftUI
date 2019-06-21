//
//  DeezerAlbum.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 29/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation

public struct GetAlbumResponse: Decodable {
    public let data: [DeezerAlbum]
    public let total: Int
}

public struct DeezerAlbum: Decodable {
    
    public let albumName: String
    public let albumId: Int

    enum CodingKeys: String, CodingKey {
        case albumName = "title"
        case albumId = "id"
    }
}
