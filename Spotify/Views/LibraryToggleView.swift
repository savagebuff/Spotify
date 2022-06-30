//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Dinar Garaev on 30.06.2022.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

///Вью для переключения контроллеров библиотеки
class LibraryToggleView: UIView {
    
    // MARK: - Public Properties
    
    public weak var delegate: LibraryToggleViewDelegate?
    
    public enum State {
        case playlist
        case album
    }
    
    public var state: State = .playlist

    // MARK: - Private Properties
    
    private lazy var playlistsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Плейлисты", for: .normal)
        button.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        return button
    }()
    
    private lazy var albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Альбомы", for: .normal)
        button.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
    }
    
    // MARK: - Public Methods
    
    public func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.3) {
            self.layoutIndicator()
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.3) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        state = .album
        UIView.animate(withDuration: 0.3) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(playlistsButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
    }
    
    private func setupFrames() {
        playlistsButton.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 40
        )
        
        albumsButton.frame = CGRect(
            x: playlistsButton.right,
            y: 0,
            width: 100,
            height: 40
        )
        
        layoutIndicator()
    }
    
    private func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(
                x: 0,
                y: playlistsButton.bottom,
                width: 100,
                height: 3
            )
        case .album:
            indicatorView.frame = CGRect(
                x: 100,
                y: playlistsButton.bottom,
                width: 100,
                height: 3
            )
        }
    }
}
