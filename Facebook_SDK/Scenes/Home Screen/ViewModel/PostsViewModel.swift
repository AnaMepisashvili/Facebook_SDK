//
//  PostsViewModel.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 31.01.22.
//

import UIKit
import FBSDKLoginKit

class PostsViewModel: NSObject {
    
    //MARK: - Variables
    private var postsList: [PostsModel] = []
    var reload: (([PostsModel])->Void)?
    
    var nextUrl: String?
    var post = PostsModel(picture_url: "", video_url: "")
    
    //MARK: - Functions
    func fetrchPosts() {
        let params = ["fields": "message, source, full_picture"]
        let request: GraphRequest = GraphRequest(graphPath: "me/feed",
                                                 parameters: params,
                                                 tokenString: Constants.FBToken,
                                                 version: nil,
                                                 httpMethod: .get)
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
                        if let paging = data["paging"] as? [String : String] {
                            self.nextUrl = paging["next"]
                        }
                    }
                    self.reload?(self.postsList)
                }
            }
        }
    }
    
    func pagination(completion: @escaping ([PostsModel]) -> Void) {
        var request: GraphRequest?
        let pageDict = Utility.dictionary(withQuery: self.nextUrl ?? "")
        request = GraphRequest.init(graphPath: "me/feed", parameters: pageDict, httpMethod: .get)
        request?.start(completion: { _, result, _ in
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async {
                    if let array = data["data"] as? [[String: Any]] {
                        var nextArray = [PostsModel]()
                        for getPost in array {
                            self.post.message = getPost["message"] as? String ?? ""
                            self.post.picture_url = getPost["full_picture"] as? String ?? ""
                            self.post.video_url = getPost["source"] as? String ?? ""
                            nextArray.append(self.post)
                        }
                        if let paging = data["paging"] as? [String : String] {
                            self.nextUrl = paging["next"]
                        }
                        completion(nextArray)
                    }
                }
            }
        })
    }
}
