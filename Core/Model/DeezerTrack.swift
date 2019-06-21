//
//  DeezerTrack.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 29/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation

public struct GetTrackResponse: Decodable {
    public let data: [DeezerTrack]
    public let total: Int
}

public struct DeezerTrack: Decodable {

    public let id: Int
    public let title: String
    public let trackPreviewUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case trackPreviewUrl = "preview"
    }
}
