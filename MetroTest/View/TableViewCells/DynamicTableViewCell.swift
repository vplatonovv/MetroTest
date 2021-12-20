//
//  DynamicTableViewCell.swift
//  MetroTest
//
//  Created by Слава Платонов on 19.12.2021.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var image: UIImage? {
        didSet {
            postImage.isHidden = false
            postImage.image = image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImage.isHidden = true
    }
    
    func configureCell(with post: Post) {
        postLabel.text = post.text
        repostLabel.text = String(post.retweetCount)
        likeLabel.text = String(post.favoriteCount)
        timeLabel.text = DateManager.shared.convertDate(from: post.createdAt)
        postImage.image = NetworkManager.shared.fetchImage(from: post.image)
    }
    
}
