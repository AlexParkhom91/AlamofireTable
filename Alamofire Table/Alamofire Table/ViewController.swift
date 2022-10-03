//
//  ViewController.swift
//  Alamofire Table
//
//  Created by Александр Пархамович on 1.10.22.
//

import UIKit

enum Key {
   static let identifire = "cell"
}

class ViewController: UIViewController {
    
    // MARK: - UI Element's
    
    let postsDataTable = UITableView()

    // MARK: - Variable's
    
    var postsData = [PostModel]()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNetworkManager()
        setupPostsDataTable()
    }
}

private extension ViewController {
    
    // MARK: - Setup Network Manager
    
    func setupNetworkManager() {
        NetworkManager.instance.loadPosts { data in
            self.postsData = data
            
            DispatchQueue.main.async {
                self.postsDataTable.reloadData()
            }
        }
    }
    
    // MARK: - Setup UserData Table
    
    func setupPostsDataTable() {
        setupAppearancePostsDataTable()
        setupLayoutPostsDataTable()
        setupBehaviorPostsDataTable()
    }
    func setupAppearancePostsDataTable() {
        postsDataTable.delegate = self
        postsDataTable.dataSource = self
        
        view.addSubview(postsDataTable)
    }
    func setupLayoutPostsDataTable() {
        postsDataTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postsDataTable.topAnchor.constraint(equalTo: view.topAnchor),
            postsDataTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsDataTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsDataTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupBehaviorPostsDataTable() {
        postsDataTable.register(UITableViewCell.self, forCellReuseIdentifier: Key.identifire)
    }
}

// MARK: - Table View Data Source

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsDataTable.dequeueReusableCell(withIdentifier: Key.identifire, for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        let userID = postsData[indexPath.row].userId
        let iD = postsData[indexPath.row].id
        let title = postsData[indexPath.row].title
        let body = postsData[indexPath.row].body
        
        cell.textLabel?.text = "UserID: \(userID)\nID: \(iD)\nTitle: \(title)\nBody: \(body)"
    
        return cell
    }
}

// MARK: - Table View Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}

