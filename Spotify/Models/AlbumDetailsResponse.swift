//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Dinar Garaev on 20.03.2022.
//

import Foundation


///Модель ответа для детальной информации об альбоме
struct AlbumDetailsResponse: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TracksResponse
}

struct TracksResponse: Codable {
     let items: [AudioTrack]
}
