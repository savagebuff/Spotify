//
//  SettingsModels.swift
//  Spotify
//
//  Created by Dinar Garaev on 13.03.2022.
//

import Foundation

///Модель настроек
struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
