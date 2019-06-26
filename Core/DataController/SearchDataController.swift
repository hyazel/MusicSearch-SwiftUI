//
//  SearchDataController.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 29/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import LDNetwork
import Combine

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
        let p = PassthroughSubject<[DeezerArtist], Error>()
        client.send(ArtistSearchRequest(artist: name)) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    return p.send(response.data.compactMap { $0 })
                }
            case .failure(let failure):
                p.send(completion: Subscribers.Completion<Error>.failure(failure))
            }
        }
        return p.eraseToAnyPublisher()
    }
    
    public func getAlbums(artistId: Int) -> AnyPublisher<[DeezerAlbum], Error> {
        let p = PassthroughSubject<[DeezerAlbum], Error>()
        
        client.send(AlbumRequest(artistId: artistId)) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    return p.send(response.data)
                }
            case .failure(let failure):
                p.send(completion: Subscribers.Completion<Error>.failure(failure))
            }
        }
        
        return p.eraseToAnyPublisher()
    }
    
    public func getTracks(albumId: Int) -> AnyPublisher<[DeezerTrack], Error> {
        let p = PassthroughSubject<[DeezerTrack], Error>()
        
        client.send(TracksRequest(albumId: albumId)) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    p.send(response.data)
                }
            case .failure(let failure):
                print(failure)
                p.send(completion: Subscribers.Completion<Error>.failure(failure))
            }
        }
        
        return p.eraseToAnyPublisher()
    }
}
