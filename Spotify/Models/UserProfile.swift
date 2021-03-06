//
//  UserProfile.swift
//  Spotify
//
//  Created by Dinar Garaev on 12.03.2022.
//

import Foundation

///Модель профиля пользователя
struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]
}
