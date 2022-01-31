//
//  FriendsListViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import FBSDKLoginKit
import UIKit

class FriendsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    private var friendsList: [FriendsModel] = [] {
        didSet {self.tableView.reloadData()}
    }
    var friendsViewModel = FriendsViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        
        configTableView()
        configureViewModel()
    }
    
    //MARK: - Functions
    func configureViewModel() {
        friendsViewModel.fetrchFriends()
        friendsViewModel.reload = { friends in
            self.friendsList.append(contentsOf: friends)
        }
    }
    
    func configTableView() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.registerNib(class: FriendsTableViewCell.self)
    }
    //MARK: - DataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: FriendsTableViewCell.self, for: indexPath)
        cell.fullNameLabel.text = friendsList[indexPath.item].name
        guard let urlStr = URL(string: friendsList[indexPath.item].pictureUrl),
              let imageData = try? Data(contentsOf: urlStr)
        else { return cell }
        cell.profileImage.image = UIImage(data: imageData)
        
        return cell
    }
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

