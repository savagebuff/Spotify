//
//  Artist.swift
//  Spotify
//
//  Created by Dinar Garaev on 12.03.2022.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
