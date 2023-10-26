//
//  DescriptionViewController.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 24/10/2023.
//

import UIKit

class DescriptionViewController: UIViewController {
    var photoModel : PhotoModel?
  
    @IBOutlet weak var myLabelView: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!

    @IBOutlet weak var myUserNameLabel: UILabel!
    
    @IBOutlet weak var myUserImage: UIImageView!
    
    @IBOutlet weak var myUserBio: UILabel!
    
    override func viewDidLoad() {
        self.title = "Detail Screen"
        super.viewDidLoad()
        setupLayout()
        myUserImage.isUserInteractionEnabled  = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        myUserImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupLayout(){
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = 15
        myImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        myImageView.layer.shadowOpacity = 0.2
        myImageView.layer.shadowColor = UIColor.black.cgColor
        if photoModel != nil {
         
            
            myImageView.setImage(from: photoModel!.urls.small)
            myLabelView.text = photoModel?.description ?? "noinfo".localized
            myUserNameLabel?.text = ((photoModel?.user?.name ?? "") + "\nInstagram : " + (photoModel?.user?.social?.instagram_username ?? "") + "\niOS Dev")
            myUserBio?.text = photoModel?.user?.bio ?? String(localized: "nobio")
        }
    }
    
    @objc func imageTapped(){
        print("On click on Image")
        UIApplication.shared.open(URL(string: (photoModel?.user?.social?.portfolio_url)!)!)
    }

}
