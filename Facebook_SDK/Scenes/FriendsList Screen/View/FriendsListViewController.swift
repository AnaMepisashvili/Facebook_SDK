//
//  FriendsListViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import FBSDKLoginKit
import UIKit

class FriendsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var friendsList: [FriendsModel] = [] {
        didSet {self.tableView.reloadData()}
    }
    var friendsViewModel = FriendsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        
        configTableView()
        configureViewModel()
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: FriendsTableViewCell.self, for: indexPath)
        cell.fullNameLabel.text = friendsList[indexPath.item].name
        
        guard let urlStr = URL(string: friendsList[indexPath.item].pictureUrl),
              let imageData = try? Data(contentsOf: urlStr)
        else { return cell }
        cell.profileImage.image = UIImage(data: imageData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
