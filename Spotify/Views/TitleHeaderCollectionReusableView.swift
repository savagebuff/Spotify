//
//  TitleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Dinar Garaev on 20.03.2022.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    // MARK: - Private Properties
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(
            x: 17,
            y: 0,
            width: width-30,
            height: height
        )
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
