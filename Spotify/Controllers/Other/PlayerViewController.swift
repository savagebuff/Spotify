//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Dinar Garaev on 12.03.2022.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

///Контроллер плеера
class PlayerViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var dataSource: PlayerDataSource?
    public weak var delegate: PlayerViewControllerDelegate?

    // MARK: - Pivate Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        setupDelegate()
        configureBarButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupFrames()
    }
    
    // MARK: - Public Methods
    
    public func refreshUI() {
        configure()
    }
    
    // MARK: - Actions
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapAction() {
        // Actions
    }
    
    // MARK: - Private Methods
    
    private func settingView() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
    }
    
    private func setupDelegate() {
        controlsView.delegate = self
    }
    
    private func setupFrames() {
        imageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width
        )
        
        controlsView.frame = CGRect(
            x: 10,
            y: imageView.bottom + 10,
            width: view.width - 20,
            height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15
        )
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapAction)
        )
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(
            with: PlayerControlsViewViewModel(
                title: dataSource?.songName,
                subtitle: dataSource?.subtitle
            )
        )
    }
}

// MARK: - PlayerControlsViewDelegate

extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapForward()
    }
    
    func playerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBackward()
    }
    
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
}
