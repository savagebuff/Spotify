//
//  RecommendedGenresResponse.swift
//  Spotify
//
//  Created by Dinar Garaev on 16.03.2022.
//

import Foundation

///Модель ответа для рекомедовованных жанров
struct RecommendedGenresResponse: Codable {
    let genres: [String]
}
