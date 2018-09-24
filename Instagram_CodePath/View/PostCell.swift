//
//  PostCell.swift
//  Instagram_CodePath
//
//  Created by SiuChun Kung on 9/23/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import AlamofireImage

class PostCell: UICollectionViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    //    @IBOutlet weak var profilePic: PFImageView!
    
    var post: PFObject! {
        didSet {
            //            profilePictureIconImageView.file = post["media"] as? PFFile
            //            profilePictureIconImageView.loadInBackground()
            usernameLabel.text = (post["author"] as? PFUser)?.username
            postImageView.file = post["media"] as? PFFile
            self.postImageView.loadInBackground()
            //
            //            numberOfLikesLabel.text = post["likesCount"] as? String
            captionLabel.text = post["caption"] as? String
        }
    }
}
