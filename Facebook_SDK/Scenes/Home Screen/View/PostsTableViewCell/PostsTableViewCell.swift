//
//  HomeTableViewCell.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 24.01.22.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLab: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
