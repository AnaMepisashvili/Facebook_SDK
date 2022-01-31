//
//  PostsViewModel.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 31.01.22.
//

import UIKit
import FBSDKLoginKit

class PostsViewModel: NSObject {
 
    private var postsList: [PostsModel] = []
    var reload: (([PostsModel])->Void)?
    
    func fetrchPosts() {
        let params = ["fields": "message, source, full_picture"]
        let request: GraphRequest = GraphRequest(graphPath: "me/feed", parameters: params, tokenString: Constants.FBToken, version: nil, httpMethod: .get)
        request.start { (_, result, error) in
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async {
                    if let array = data["data"] as? [[String: Any]] {
                        for video in array {
                            let image = video["full_picture"] as? String
                            let message = video["message"] as? String
                            let source = video["source"] as? String ?? ""
                            
                            let newPostModel = PostsModel(message: message,
                                                          picture_url: image ?? "",
                                                          video_url: source)
                            self.postsList.append(newPostModel)
                        }
                    }
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
                    self.reload?(self.postsList)

                }
            }
        }
    }
}
