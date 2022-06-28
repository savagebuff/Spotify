//
//  CategoryCollectionViewCell.swift
//  Spotify
//
//  Created by Dinar Garaev on 23.03.2022.
//

import UIKit
import SDWebImage

///Коллекция категорий
final class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    public static let identifier = "CategoryCollectionViewCell"
    
    // MARK: - Private Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemPurple,
        .systemBlue,
        .systemOrange,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .systemIndigo,
        .systemTeal,
        .systemBrown,
        .darkGray
    ]
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
    }
    
    // MARK: - Public Methods
    
    public func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
//        расскомментируй чтобы подцеплять иконки (плохо выглядит)
//        imageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
    
    // MARK: - Private Methods
    
    private func setupFrames() {
        label.frame = CGRect(
            x: 10,
            y: contentView.height/2,
            width: contentView.width-20,
            height: contentView.height/2
        )
        
        imageView.frame = CGRect(
            x: contentView.width/2,
            y: 10,
            width: contentView.width/2,
            height: contentView.height/2
        )
    }
}
