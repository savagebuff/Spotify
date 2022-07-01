//
//  ActionLabelView.swift
//  Spotify
//
//  Created by Dinar Garaev on 01.07.2022.
//

import UIKit

struct ActionLabelViewViewModel {
    let text: String
    let actionTitle: String
}

protocol ActionLabelViewDelegate: AnyObject {
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView)
}

///Вью-уведомление о том, что плейлистов нет
class ActionLabelView: UIView {
    
    // MARK: - Public Properties
    
    public weak var delegate: ActionLabelViewDelegate?
    
    // MARK: - Private Propertis
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        isHidden = true
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
    
    public func configure(with viewModel: ActionLabelViewViewModel) {
        label.text = viewModel.text
        button.setTitle(viewModel.actionTitle, for: .normal)
    }
    
    // MARK: - Actions
    
    @objc private func didTapButton() {
        delegate?.ActionLabelViewDidTapButton(self)
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(button)
        addSubview(label)
    }
    
    private func setupFrames() {
        button.frame = CGRect(
            x: 0,
            y: height - 40,
            width: width,
            height: 40
        )
        
        label.frame = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: height - 45
        )
    }
    
}
