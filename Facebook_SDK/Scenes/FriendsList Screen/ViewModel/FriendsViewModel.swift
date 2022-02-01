//
//  FriendsViewModel.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 30.01.22.
//

import Foundation
import FBSDKLoginKit

class FriendsViewModel: NSObject {
    
    //MARK: - Variables
    private var friendsList: [FriendsModel] = []
    var reload: (([FriendsModel])->Void)?
    
    //MARK: - Functions
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
                    let userName = userDictionary["name"] as? String,
                    let userPicDict = userDictionary["picture"] as? NSDictionary,
                    let userPicData = userPicDict["data"] as? NSDictionary,
                    let userPicURL = userPicData["url"] as? String
                else { return }
                
                let newFriendModel = FriendsModel(name: userName, pictureUrl: userPicURL)
                self.friendsList.append(newFriendModel)
            }
            self.reload?(self.friendsList)
        }
    }
}
