//
//  SearchResult.swift
//  Spotify
//
//  Created by Dinar Garaev on 17.04.2022.
//

import Foundation

///Модель результатов поиска
enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
