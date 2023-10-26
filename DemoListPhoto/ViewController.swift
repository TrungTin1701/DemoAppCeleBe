//
//  ViewController.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 23/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire



class ViewController: UIViewController, UITableViewDelegate {
   private var viewmodel = PhotoViewModel()
    
    private var bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    @IBOutlet weak var myPhotoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewmodel.getPhotoData()
        setupCell()
        bindTableViewData()
        if let currentLanguage = Bundle.main.preferredLocalizations.first {
            let filePath = Bundle.main.path(forResource: currentLanguage, ofType: "lproj")
            
            print("Language code is \(filePath ?? currentLanguage)")
        } else {
            print("Unable to determine the current language.")
        }

    }
    
    func setupCell(){
        self.myPhotoTableView.separatorStyle = .none
        myPhotoTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        myPhotoTableView.rx.setDelegate(self).disposed(by: bag)
    }
    
    func bindTableViewData(){
        viewmodel.items.bind(to: myPhotoTableView.rx.items(cellIdentifier: "PhotoTableViewCell", cellType: PhotoTableViewCell.self)){
            row,model,cell in
            cell.myDiscription?.text = model.alt_description
            cell.likeCount?.text = String(model.likes)
            cell.myPhotoView.setImage(from: model.urls.small)
        }
        .disposed(by: bag)
        
        myPhotoTableView.rx.modelSelected(PhotoModel.self).bind{ [weak self] model in
            let descriptionScreen = DescriptionViewController()
            descriptionScreen.photoModel = model
            self?.navigationController?.pushViewController(descriptionScreen, animated: true)
        }.disposed(by: bag)
    }
}

extension ViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

}
