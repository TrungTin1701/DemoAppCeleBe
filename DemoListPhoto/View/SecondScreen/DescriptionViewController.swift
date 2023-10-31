//
//  DescriptionViewController.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 24/10/2023.
//

import UIKit
import AVKit
import Foundation


class DescriptionViewController: UIViewController {
    var photoModel : PhotoModel?
    
    @IBOutlet weak var myLabelView: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!

    @IBOutlet weak var myUserNameLabel: UILabel!
    
    @IBOutlet weak var myUserImage: UIImageView!
    
    @IBOutlet weak var myUserBio: UILabel!
    

    var customButton = CustomButton()
    
    
   

    override func viewDidLoad() {
        self.title = "Detail Screen"
        super.viewDidLoad()
        setupLayout()
        myUserImage.isUserInteractionEnabled  = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
       // view.addSubview(customGradientLabel)
        myUserImage.addGestureRecognizer(tapGestureRecognizer)
       
        setupCustomButtonConstraints()
        customButton.setTitle("PlayVideo", for: .normal)
        addActionToCustomButton()

    }
   func setupCustomViewConstrainsts(){
       let customGradientLabel = CustomGradientLabelView(text:photoModel?.user?.bio ?? String(localized: "nobio"), frame: CGRect(x: 0, y: 0, width: 0, height: 0))
       view.addSubview(customGradientLabel)
       customGradientLabel.translatesAutoresizingMaskIntoConstraints = false

       customGradientLabel.topAnchor.constraint(equalTo: customButton.bottomAnchor,constant: 10).isActive = true
       customGradientLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
       customGradientLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
       customGradientLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    

    }
    func setupCustomButtonConstraints(){
        view.addSubview(customButton)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        customButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        customButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customButton.topAnchor.constraint(equalTo: myUserBio.bottomAnchor,constant: 10).isActive = true
        print("CustomButton is shown")
        setupCustomViewConstrainsts()
    }
    
    func setupLayout(){
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = 15
        myImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        myImageView.layer.shadowOpacity = 0.2
        myImageView.layer.shadowColor = UIColor.black.cgColor
        if photoModel != nil {
            myImageView.setImage(from: photoModel!.urls.small)
            myUserImage.setImage(from: photoModel!.urls.small)
            myLabelView.text = photoModel?.description ?? "noinfo".localized
            myUserNameLabel?.text = ((photoModel?.user?.name ?? "") + "\nInstagram : " + (photoModel?.user?.social?.instagram_username ?? "") + "\niOS Dev")
            myUserBio?.text = photoModel?.user?.bio ?? String(localized: "nobio")
        }
     
    }
    
    @objc func imageTapped(){
        print("On click on Image")
        UIApplication.shared.open(URL(string: (photoModel?.user?.social?.portfolio_url) ?? "https://example.com/")!)
    }

    func addActionToCustomButton() {
        customButton.addTarget(self, action: #selector(playVideoCustomButton), for: .touchUpInside)
    }

    @objc func playVideoCustomButton(){
       
        customButton.shakeButton()
//        guard let path = Bundle.main.path(forResource: "test", ofType: "mp4") else { debugPrint("Mp4 not found "); return }
//        
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        present(playerController, animated: true) {
//            
//            player.play()
//        }
        self.navigationController!.pushViewController(ExpandedCellViewController(), animated: true)
    }
    
}
