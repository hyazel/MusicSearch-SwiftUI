//
//  AlbumDetailViewModel.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 29/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import Core
import Combine
import SwiftUI

struct TrackCellViewModel {
    let title: String
    let previewUrl: String
}

final class AlbumDetailViewModel: BindableObject {

    private let dependencies: AlbumDetailDependencies
    private var cancelable: Cancellable?
    
    // Output
    var didChange = PassthroughSubject<Void, Never>()
    var tracksCellViewModel: [TrackCellViewModel] = [] {
        didSet {
            didChange.send()
        }
    }
    
    init(dependencies: AlbumDetailDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: ws calls
extension AlbumDetailViewModel {
    func getTracksFromFirstAlbum() {
        cancelable = dependencies.searchDataController
            .getAlbums(artistId: dependencies.artistId)
            .flatMap { (album) -> AnyPublisher<[DeezerTrack], Error> in
                return self.dependencies.searchDataController.getTracks(albumId: album[0].albumId)
            }
            .replaceError(with: [])
            .map { self.buildTrackCellViewModel(from: $0) }
            .assign(to: \AlbumDetailViewModel.tracksCellViewModel, on: self)
    }
}

// MARK: cellViewModel builder
private extension AlbumDetailViewModel {
    func buildTrackCellViewModel(from tracksResp: [DeezerTrack]) -> [TrackCellViewModel]{
        return tracksResp.map {
            TrackCellViewModel(title: $0.title,
                               previewUrl: $0.trackPreviewUrl)
        }
    }
}
