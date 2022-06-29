//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Dinar Garaev on 29.06.2022.
//

import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView)
}

///Вью плеера
final class PlayerControlsView: UIView {
    
    // MARK: - Public properties
    
    public weak var delegate: PlayerControlsViewDelegate?
    
    // MARK: - Private Properties
    
    private let volumeSlider : UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "This is my song"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "HomelessGod"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "backward.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular)
        )
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapBackward), for: .touchUpInside)
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "forward.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular)
        )
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapForward), for: .touchUpInside)
        return button
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "pause.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular)
        )
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
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
    
    // MARK: - Actions
    
    @objc private func didTapBackward() {
        delegate?.playerControlsViewDidTapBackwardButton(self)
    }
    
    @objc private func didTapForward() {
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc private func didTapPlayPause() {
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        
        addSubview(volumeSlider)
        
        addSubview(backwardButton)
        addSubview(playPauseButton)
        addSubview(forwardButton)
        
        clipsToBounds = true
    }
    
    private func setupFrames() {
        nameLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: 50
        )
        
        subtitleLabel.frame = CGRect(
            x: 0,
            y: nameLabel.bottom + 10,
            width: width,
            height: 50
        )
        
        volumeSlider.frame = CGRect(
            x: 10,
            y: subtitleLabel.bottom + 20,
            width: width - 20,
            height: 44
        )
        
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(
            x: (width - buttonSize) / 2,
            y: volumeSlider.bottom + 30,
            width: buttonSize,
            height: buttonSize
        )
        
        backwardButton.frame = CGRect(
            x: playPauseButton.left - 80 - buttonSize,
            y: playPauseButton.top,
            width: buttonSize,
            height: buttonSize
        )
        
        forwardButton.frame = CGRect(
            x: playPauseButton.right + 80,
            y: playPauseButton.top,
            width: buttonSize,
            height: buttonSize
        )
    }
}
