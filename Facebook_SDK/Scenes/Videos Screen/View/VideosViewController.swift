//
//  VideosViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import FBSDKLoginKit
import UIKit

class VideosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var videosList: [VideosModel] = [] {
        didSet {self.tableView.reloadData()}
    }
    var videosViewModel = VideosViewModel()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Videos"
        
        configTableView()
        configureViewModel()
    }
    
    func configureViewModel() {
        videosViewModel.fetrchVideos()
        videosViewModel.reload = { videos in
            self.videosList.append(contentsOf: videos)
        }
    }
    
    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(class: VideosTableViewCell.self)
//        tableView.allowsSelection = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: VideosTableViewCell.self, for: indexPath)
        cell.configureVideo(with: videosList[indexPath.row])
        return cell
    }
    
    func scrollViewwillBeginDragging(_ scrollView: UIScrollView) {
        let cells = tableView.visibleCells.compactMap({ $0 as? VideosTableViewCell })
        cells.forEach { videoCell in
            if videoCell.playing {
                videoCell.stopVideo()
            }
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}
