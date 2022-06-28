//
//  Playlist.swift
//  Spotify
//
//  Created by Dinar Garaev on 12.03.2022.
//

import Foundation

///Модель плейлистов
struct Playlist: Codable {
    let description: String
    let external_urls: [String : String]
    let id : String
    let images: [APIImage]
    let name: String
    let owner: User
}
