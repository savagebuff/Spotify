//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Dinar Garaev on 20.03.2022.
//

import SDWebImage
import UIKit

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

///Вью хеддера плейлистов
final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Public Propertis
    
    public static let identifier = "PlaylistHeaderCollectionReusableView"
    public weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    // MARK: - Private Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private lazy var playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(systemName: "play.fill",
                            withConfiguration: UIImage.SymbolConfiguration(
                                pointSize: 28,
                                weight: .regular
                            )
        )
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingView()
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
    
    func configure(with viewModel: PlaylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = viewModel.ownerName
        imageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
    
    // MARK: - Actions
    
    @objc private func didTapPlayAll() {
        delegate?.PlaylistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
    
    // MARK: - Private Methods
    
    private func settingView() {
        backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(playAllButton)
    }
    
    private func setupFrames() {
        let imageSize: CGFloat = height/1.8
        imageView.frame = CGRect(
            x: (width-imageSize)/2,
            y: 20,
            width: imageSize,
            height: imageSize
        )
        
        nameLabel.frame = CGRect(
            x: 10,
            y: imageView.bottom,
            width: width-20,
            height: 44
        )
        
        descriptionLabel.frame = CGRect(
            x: 10,
            y: nameLabel.bottom,
            width: width-20,
            height: 44
        )
        
        ownerLabel.frame = CGRect(
            x: 10,
            y: descriptionLabel.bottom,
            width: width-20,
            height: 44
        )
        
        playAllButton.frame = CGRect(
            x: width-76,
            y: height-76,
            width: 56,
            height: 56
        )
    }
}
