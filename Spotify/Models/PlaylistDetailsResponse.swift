//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by Dinar Garaev on 20.03.2022.
//

import Foundation

///Модель ответа для детальной информации об альбоме
struct PlaylistDetailsResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
