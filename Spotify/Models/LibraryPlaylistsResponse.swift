//
//  LibraryPlaylistsResponse.swift
//  Spotify
//
//  Created by Dinar Garaev on 01.07.2022.
//

import Foundation

///Модель для получения плейлистов текущего пользователя
struct LibraryPlaylistsResponse: Codable {
    let items: [Playlist]
}
