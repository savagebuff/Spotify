//
//  Artist.swift
//  Spotify
//
//  Created by Dinar Garaev on 12.03.2022.
//

import Foundation

///Модель артистов
struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
