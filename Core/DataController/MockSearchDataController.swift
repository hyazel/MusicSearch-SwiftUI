//
//  MockSearchDataController.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 30/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation

public class MockSearchDataController: SearchDataControlleable {
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
    
    public func getAlbum(artistId: Int, completion: @escaping (Result<[DeezerAlbum], Error>) -> Void) {
        let bundle = Bundle(for: type(of: self))
        let mockUrl = bundle.url(forResource: mockType.rawValue, withExtension: "json")
        if let url = mockUrl {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GetAlbumResponse.self, from: data)
                completion(.success(jsonData.data))
            } catch {
                completion(.failure(error))
                print("error")
            }
        } else {
            print("couldn't found json")
        }
    }

    public func getTrack(albumId: Int, completion: @escaping (Result<[DeezerTrack], Error>) -> Void) {
        let bundle = Bundle(for: type(of: self))
        let mockUrl = bundle.url(forResource: "tracks", withExtension: "json")
        if let url = mockUrl {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GetTrackResponse.self, from: data)
                completion(.success(jsonData.data))
            } catch {
                completion(.failure(error))
                print("error")
            }
        } else {
            print("couldn't found json")
        }
    }

    public func getArtists(name: String, completion: @escaping (Result<[DeezerArtist], Error>) -> Void) {
        let bundle = Bundle(for: type(of: self))
        let mockUrl = bundle.url(forResource: mockType.rawValue, withExtension: "json")
        if let url = mockUrl {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GetSearchArtistResponse.self, from: data)
                completion(.success(jsonData.data.compactMap { $0 }))
            } catch {
                completion(.failure(error))
            }
        } else {
            print("couldn't found json")
        }
    }
}
