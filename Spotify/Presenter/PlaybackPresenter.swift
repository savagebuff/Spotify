//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Dinar Garaev on 29.06.2022.
//

import UIKit

///Класс отвечающий за проигрывание песень
final class PlaybackPresenter {
    
    // MARK: - Public properties
    
    public static func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        let vc = PlayerViewController()
        vc.title = track.name
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        
    }
    
    public static func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}
