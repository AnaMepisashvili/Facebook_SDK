//
//  VideosViewModel.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 31.01.22.
//

import UIKit
import FBSDKLoginKit

class VideosViewModel: NSObject {
    
    //MARK: - Variables
    private var videosList: [VideosModel] = []
    var reload: (([VideosModel])->Void)?
    
    //MARK: - Functions
    func fetrchVideos() {
        let params = ["fields": "message, source, created_time"]
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
                            let createdTime = video["created_time"] as? String
                            let message = video["message"] as? String
                            let source = video["source"] as? String ?? ""
                            
                            let newVideoModel = VideosModel(created_time:  createdTime,
                                                            message: message,
                                                            video_url: source)
                            if newVideoModel.video_url != "" {
                                self.videosList.append(newVideoModel)
                            }
                        }
                    }
                    self.reload?(self.videosList)
                }
            }
        }
    }
}
