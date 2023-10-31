//
//  PhotoTableViewCell.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 23/10/2023.
//

import UIKit


class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myPhotoView: UIImageView!
    
    @IBOutlet weak var myCardView: UIView!
    
    @IBOutlet weak var myDiscription: UILabel!
    
    @IBOutlet weak var likeCount: UILabel!
    
    var imageURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myCardView.clipsToBounds = false
        myCardView.layer.cornerRadius = 15
        myCardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        myCardView.layer.shadowOpacity = 0.2
        myCardView.layer.shadowColor = UIColor.black.cgColor
        myPhotoView.layer.cornerRadius = 15
        self.backgroundColor = UIColor(red: 247.0/255, green: 247.0/255, blue: 247.0/255, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

  
    
}




