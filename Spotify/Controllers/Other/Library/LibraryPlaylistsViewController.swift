//
//  LibraryPlaylistsViewController.swift
//  Spotify
//
//  Created by Dinar Garaev on 30.06.2022.
//

import UIKit
import AVFoundation

class LibraryPlaylistsViewController: UIViewController {

    // MARK: - Private Properties
    
    private var playlists = [Playlist]()
    
    private let noPlayplistView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(
            SearchResultSubtitleTableViewCell.self,
            forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier
        )
        tableView.isHidden = true
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupNoPlaylistView()
        getCurrentUserPlaylists()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupFrames()
    }
    
    // MARK: - Public Methods
    
    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(
            title: "Новый Плейлист",
            message: "Введите название плейлиста",
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = "Плейлист..."
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty
            else {
                return
            }
            
            APICaller.shared.createPlaylist(with: text) { [weak self] succes in
                if succes {
                    self?.getCurrentUserPlaylists()
                } else {
                    print("Failed to create Playlist")
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func getCurrentUserPlaylists() {
        APICaller.shared.getCurrentUserPlaylist { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            noPlayplistView.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.reloadData()
            noPlayplistView.isHidden = true
            tableView.isHidden = false
        }
    }
    
    private func setupNoPlaylistView() {
        view.addSubview(noPlayplistView)
        noPlayplistView.delegate = self
        noPlayplistView.configure(
            with: ActionLabelViewViewModel(
                text: "У вас еще нет плейлистов",
                actionTitle: "Создать"
            )
        )
    }

    private func setupFrames() {
        noPlayplistView.frame = CGRect(
            x: 0,
            y: 0,
            width: 150,
            height: 150
        )
        noPlayplistView.center = view.center
        
        tableView.frame = view.bounds
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

// MARK: - ActionLabelViewDelegate

extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        showCreatePlaylistAlert()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension LibraryPlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultSubtitleTableViewCell.identifier,
            for: indexPath
        ) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playist = playlists[indexPath.row]
        cell.configure(
            with: SearchResultSubtitleTableViewCellViewModel(
                title: playist.name,
                subtitle: playist.owner.display_name,
                imageURL: URL(string: playist.images.first?.url ?? "")
            )
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
