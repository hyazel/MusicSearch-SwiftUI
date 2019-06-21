//
//  SearchDataController.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 29/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import LDNetwork

public protocol SearchDataControlleable {
    func getArtists(name: String, completion: @escaping (Result<[DeezerArtist], Error>) -> Void)
//    func getAlbum(artistId: Int, completion: @escaping (Result<[DeezerAlbum], Error>) -> Void)
    func getTrack(albumId: Int, completion: @escaping (Result<[DeezerTrack], Error>) -> Void)
}

public final class SearchDataController: SearchDataControlleable {
    private let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }
}

extension SearchDataController {
    public func getArtists(name: String, completion: @escaping (Result<[DeezerArtist], Error>) -> Void) {
        client.send(ArtistSearchRequest(artist: name)) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(.success(response.data.compactMap {$0} ))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

//    public func getAlbum(artistId: Int, completion: @escaping (Result<[DeezerAlbum], Error>) -> Void) {
//        client.send(AlbumRequest(artistId: artistId)) { (result) in
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    completion(.success(response.data))
//                }
//            case .failure(let failure):
//                completion(.failure(failure))
//            }
//        }
//    }

    public func getTrack(albumId: Int, completion: @escaping (Result<[DeezerTrack], Error>) -> Void) {
        client.send(TracksRequest(albumId: albumId)) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(.success(response.data))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
