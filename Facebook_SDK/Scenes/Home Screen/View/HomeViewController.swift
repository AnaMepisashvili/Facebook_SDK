//
//  ViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import FBSDKLoginKit
import UIKit

//enum Cell: String {
//    case videoCell = "VideoTableViewCell"
//    case postCell = "PostsTableViewCell"
//}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
//    private var postsList: [PostsModel] = [] {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    private var postsList: [PostsModel] = [] {
        didSet {self.tableView.reloadData()}
    }
    var postsViewModel = PostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
//        fetrchPosts()
        configTableView()
        configureViewModel()
    }
    
    func configureViewModel() {
        postsViewModel.fetrchPosts()
        postsViewModel.reload = { posts in
            self.postsList.append(contentsOf: posts)
        }
    }
    
    
    
//    func fetrchPosts() {
//        let params = ["fields": "message, source, full_picture"]
//        let request: GraphRequest = GraphRequest(graphPath: "me/feed", parameters: params, tokenString: Constants.FBToken, version: nil, httpMethod: .get)
//        request.start { (_, result, error) in
//            if let data: [String: Any] = result as? [String: Any] {
//                DispatchQueue.main.async {
//                    if let array = data["data"] as? [[String: Any]] {
//                        for video in array {
//                            let image = video["full_picture"] as? String
//                            let message = video["message"] as? String
//                            let source = video["source"] as? String ?? ""
//                            
//                            let newPostModel = PostsModel(message: message,
//                                                          picture_url: image ?? "",
//                                                          video_url: source)
//                            self.postsList.append(newPostModel)
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
//    }
    
    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(class: PostsTableViewCell.self)
        tableView.registerNib(class: VideosTableViewCell.self)
        
        //        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: "VideoTableViewCell")
        //        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "PostsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? VideosTableViewCell {
            if cell.playing {
                cell.stopVideo()
            }
            else {
                cell.startVideo()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if postsList[indexPath.row].video_url == "" {
            let cell = tableView.deque(class: PostsTableViewCell.self, for: indexPath)
            cell.descriptionLab.text = postsList[indexPath.row].message
            guard let urlStr = URL(string: postsList[indexPath.row].picture_url),
                  let imageData = try? Data(contentsOf: urlStr)
            else { return cell }
            
            cell.postImg.image = UIImage(data: imageData)
            return cell
        } else {
            let cell = tableView.deque(class: VideosTableViewCell.self, for: indexPath)
            cell.configureVideo(with: postsList[indexPath.row])
//            cell.descriptionLabel.text = postsList[indexPath.row].message
//            if let url = URL(string:postsList[indexPath.item].video_url) {
//            cell.videoURL = url
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

