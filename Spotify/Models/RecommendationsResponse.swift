//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Dinar Garaev on 17.03.2022.
//

import Foundation

///Модель ответа для рекомендаций
struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
