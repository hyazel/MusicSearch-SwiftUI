//
//  SearchDataController.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 29/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import Combine
import LDNetwork

public protocol SearchDataControlleable {
    func getArtists(name: String) -> AnyPublisher<[DeezerArtist], Error>
    func getAlbums(artistId: Int) -> AnyPublisher<[DeezerAlbum], Error>
    func getTracks(albumId: Int) -> AnyPublisher<[DeezerTrack], Error>
}

public final class SearchDataController: SearchDataControlleable {
    
    private let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }
}

extension SearchDataController {
    public func getArtists(name: String) -> AnyPublisher<[DeezerArtist], Error> {
        return AnyPublisher { subscriber in
            self.client.send(ArtistSearchRequest(artist: name)) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        _ = subscriber.receive(response.data.compactMap { $0 })
                    }
                case .failure(let failure):
                    subscriber.receive(completion: Subscribers.Completion<Error>.failure(failure))
                }
            }
        }
    }
    
    public func getAlbums(artistId: Int) -> AnyPublisher<[DeezerAlbum], Error> {
        return AnyPublisher { subscriber in
            self.client.send(AlbumRequest(artistId: artistId)) { (result) in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        _ = subscriber.receive(response.data)
                    }
                case .failure(let failure):
                    subscriber.receive(completion: Subscribers.Completion<Error>.failure(failure))
                }
            }
        }
    }
    
    public func getTracks(albumId: Int) -> AnyPublisher<[DeezerTrack], Error> {
        
        return AnyPublisher { subscriber in
            self.client.send(TracksRequest(albumId: albumId)) { (result) in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        _ = subscriber.receive(response.data)
                    }
                case .failure(let failure):
                    print(failure)
                    subscriber.receive(completion: Subscribers.Completion<Error>.failure(failure))
                }
            }
        }
    }
}
