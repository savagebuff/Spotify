//
//  TitleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Dinar Garaev on 20.03.2022.
//

import UIKit

///Вью тайтла для главного экрана
final class TitleHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Public Properties
    
    public static let identifier = "TitleHeaderCollectionReusableView"
    
    // MARK: - Private Properties
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(
            x: 17,
            y: 0,
            width: width-30,
            height: height
        )
    }
    
    // MARK: - Public Methods
    
    public func configure(with title: String) {
        label.text = title
    }
}
