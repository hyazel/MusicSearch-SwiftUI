//
//  DeezerArtist.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 29/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation

public struct GetSearchArtistResponse: Decodable {
    public let data: [DeezerArtist?]
    public let total: Int
    public let next: String?
}

public struct DeezerArtist: Decodable {

    public let id: Int
    public let name: String
    public let pictureUrl: URL?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pictureUrl = "picture_big"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        pictureUrl = try? container.decodeIfPresent(URL.self, forKey: .pictureUrl)
    }
}
