//
//  AuthResponse.swift
//  Spotify
//
//  Created by Dinar Garaev on 13.03.2022.
//

import Foundation

///Модель ответа при авторизации
struct AuthResponse : Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}
