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
    
    private var friendsList: [FriendsModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Friends"
        
        configTableView()
        fetrchFriends()
    }
    
    func fetrchFriends() {
        let params = ["fields": "name, picture.type(large)"]
        let graphRequest = GraphRequest(graphPath: "me/friends",
                                        parameters: params,
                                        tokenString: Constants.FBToken,
                                        version: nil,
                                        httpMethod: .get)
        graphRequest.start { (connection, result, error) in
            
            guard let json = result as? NSDictionary,
                  let data = json["data"] as? NSArray
            else {
                print("Guard failed!")
                return
            }
            
            for i in 0..<data.count {
                guard
                    let userDictionary = data[i] as? NSDictionary,
                    let userName       = userDictionary["name"] as? String,
                    let userPicDict    = userDictionary["picture"] as? NSDictionary,
                    let userPicData    = userPicDict["data"] as? NSDictionary,
                    let userPicURL     = userPicData["url"] as? String
                else { return }
                
                let newFriendModel = FriendsModel(name: userName, pictureUrl: userPicURL)
                self.friendsList.insert(newFriendModel, at: 0)
            }
            self.tableView.reloadData()
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

