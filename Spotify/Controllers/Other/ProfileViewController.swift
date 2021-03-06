//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Dinar Garaev on 12.03.2022.
//

import SDWebImage
import UIKit

///Контроллер профиля пользователя
class ProfileViewController: UIViewController {

    // MARK: - Private Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        return tableView
    }()
    
    private var models = [String]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        setupDelegates()
        fetchProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Private Methods

    private func settingView() {
        title = "Профиль"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print("Profile Erorr: \(error.localizedDescription)")
                    self?.failedTogetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        // configure table models
        models.append("Полное Имя: \(model.display_name)")
        models.append("Email адрес: \(model.email)")
        models.append("ID Пользователя: \(model.id)")
        models.append("Тарифный план: \(model.product)")
        createTableHeader(with: model.images.first?.url)
        tableView.reloadData()
    }
    
    private func createTableHeader(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }
        
        let headerView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.width / 1.5
            )
        )
        
        let imageSize: CGFloat = headerView.height / 2
        let imageView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: imageSize,
                height: imageSize
            )
        )
        
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        
        tableView.tableHeaderView = headerView
    }
    
    private func failedTogetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
