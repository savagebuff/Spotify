//
//  NewReleasesCellViewModel.swift
//  Spotify
//
//  Created by Dinar Garaev on 19.03.2022.
//

import Foundation

///Вью модель для ячейки новых релизов
struct NewReleasesCellViewModel {
    let name: String
    let artworkURL: URL?
    let numberOfTracks: Int
    let artistName: String
}
