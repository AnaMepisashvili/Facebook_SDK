//
//  FriendsListViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import UIKit

class FriendsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friends"
        
        configTableView()
    }
        
    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(class: FriendsTableViewCell.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: FriendsTableViewCell.self, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

