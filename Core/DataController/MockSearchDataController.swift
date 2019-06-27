//
//  MockSearchDataController.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 30/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import Combine

public class MockSearchDataController: SearchDataControlleable {
    public func getAlbums(artistId: Int) -> AnyPublisher<[DeezerAlbum], Error> {
        let bundle = Bundle(for: type(of: self))
        let mockUrl = bundle.url(forResource: mockType.rawValue, withExtension: "json")
        if let url = mockUrl {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GetAlbumResponse.self, from: data)
                
                return Publishers.Once(jsonData.data).eraseToAnyPublisher() //.replaceError(with: []).eraseToAnyPublisher()
            } catch {
                return Publishers.Once([]).eraseToAnyPublisher()
            }
        } else {
            return Publishers.Once([]).eraseToAnyPublisher()
        }
    }
    
    public func getTracks(albumId: Int) -> AnyPublisher<[DeezerTrack], Error> {
        let bundle = Bundle(for: type(of: self))
        let mockUrl = bundle.url(forResource: "tracks", withExtension: "json")
        if let url = mockUrl {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GetTrackResponse.self, from: data)
                return Publishers.Once(jsonData.data).eraseToAnyPublisher()
            } catch {
                return Publishers.Once([]).eraseToAnyPublisher()
            }
        } else {
            return Publishers.Once([]).eraseToAnyPublisher()
        }
    }
    
    public func getArtists(name: String) -> AnyPublisher<[DeezerArtist], Error> {
        let bundle = Bundle(for: type(of: self))
        let mockUrl = bundle.url(forResource: mockType.rawValue, withExtension: "json")
        if let url = mockUrl {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GetSearchArtistResponse.self, from: data)
                return Publishers.Once(jsonData.data.compactMap { $0 }).eraseToAnyPublisher()
            } catch {
                return Publishers.Once([]).eraseToAnyPublisher()
            }
        } else {
            return Publishers.Once([]).eraseToAnyPublisher()
        }
    }
    
    public enum MockType: String {
        case artists = "artists"
        case artistsNoId = "artistsNoId"
        case artistsNoPicture = "artistsNoPicture"
        case albums = "albums"
        case albumsNull = "albumsNull"
        case tracks = "tracks"
    }

    private let mockType: MockType

    public init(mockType: MockType) {
        self.mockType = mockType
    }
}
