//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Dinar Garaev on 29.06.2022.
//

import AVFoundation
import UIKit

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

///Класс отвечающий за проигрывание песень
final class PlaybackPresenter {
    
    // MARK: - Public Properties
    
    public static let shared = PlaybackPresenter()
    
    // MARK: - Private Methods
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    private var index = 0
    
    private var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let player = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }
        return nil
    }
    
    private var playerVC: PlayerViewController?
    private var player: AVPlayer?
    private var playerQueue: AVQueuePlayer?
    
    // MARK: - Public Methods
    
    public func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    public func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        self.tracks = tracks
        self.track = nil
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else {
                return nil
            }
            return AVPlayerItem(url: url)
        }))
        self.playerQueue?.volume = 0.5
        self.playerQueue?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }
}

// MARK: - PlayerViewControllerDelegate

extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        } else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
        } else if let player = playerQueue {
            player.advanceToNextItem()
            index += 1
            
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
            player?.play()
        } else if let firstItem = playerQueue?.items().first {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0.5
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

// MARK: - PlayerDataSource

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}
