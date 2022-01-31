//
//  ViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import FBSDKLoginKit
import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    private var postsList: [PostsModel] = [] {
        didSet {self.tableView.reloadData()}
    }
    var postsViewModel = PostsViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        configTableView()
        configureViewModel()
    }
    
    //MARK: - Functions
    func configureViewModel() {
        postsViewModel.fetrchPosts()
        postsViewModel.reload = { posts in
            self.postsList.append(contentsOf: posts)
        }
    }
    
    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(class: PostsTableViewCell.self)
        tableView.registerNib(class: VideosTableViewCell.self)
    }
    //MARK: - DataSource
    
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
            return cell
        }
    }
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.postsList.count == indexPath.row + 1 {
            postsViewModel.pagination { post in
                self.postsList.append(contentsOf: post)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? VideosTableViewCell {
            if cell.playing {
                cell.stopVideo()
            } else {
                cell.startVideo()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

