//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Dinar Garaev on 24.03.2022.
//

import Foundation

///Модель ответа для всех категорий
struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
