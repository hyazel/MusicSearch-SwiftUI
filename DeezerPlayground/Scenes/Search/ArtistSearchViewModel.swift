//
//  ArtistSearchViewModel.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 29/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import Core
import Combine
import SwiftUI

struct ArtistCellViewModel: Identifiable {
    let title: String
    let image: URL?
    let id: Int
}

final class ArtistSearchViewModel: BindableObject {

    private let dependencies: ArtistSearchDependencies
    private var cancellable: Cancellable?
    // Input
    var searchBarInput: String = "" {
        didSet {
            processSearchBarInput(searchBarInput)
        }
    }

    // Output
    let didChange = PassthroughSubject<Void, Never>()
    private(set) var artistsCellViewModel: [ArtistCellViewModel] = [] {
        didSet {
            didChange.send()
        }
    }

    init(dependencies: ArtistSearchDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: search artist ws call
private extension ArtistSearchViewModel {
    func searchArtist(text: String) {
        cancellable = dependencies.searchDataController
            .getArtists(name: text)
            .replaceError(with: [])
            .map { self.buildAlbumCellViewModel(from: $0) }
            .assign(to: \.artistsCellViewModel, on: self)
    }
}

// MARK: cellViewModel builder
private extension ArtistSearchViewModel {
    func buildAlbumCellViewModel(from artistsResp: [DeezerArtist]) -> [ArtistCellViewModel] {
        return artistsResp.map { artist in
            return ArtistCellViewModel(title: artist.name, image: artist.pictureUrl, id: artist.id)
        }
    }
}

// MARK: search bar handling
private extension ArtistSearchViewModel {
    func processSearchBarInput(_ text: String) {
        if text == "" {
            artistsCellViewModel = []
        } else {
            searchArtist(text: text)
        }
    }
}
