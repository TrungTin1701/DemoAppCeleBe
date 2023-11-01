//
//  PlayVideoViewController.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 01/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
class PlayVideoViewController: UIViewController {
    private var vm = VideoViewModel()
    private var bag = DisposeBag()
    
    @IBOutlet weak var videoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PlayVideo"
        navigationController?.navigationBar.isHidden = true
        self.setupCell()
        self.binding()
        self.vm.getdata()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func setupCell(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        videoCollectionView.isPagingEnabled = true
        videoCollectionView.collectionViewLayout = layout
        videoCollectionView.register(VideoCellCollectionView.self, forCellWithReuseIdentifier:VideoCellCollectionView.identifier )
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
    }
    func binding(){
        vm.data.subscribe { [weak self] video in
            guard let self = self else {return}
            videoCollectionView.reloadData()
        }.disposed(by: self.bag)
        
    }

   

}
extension PlayVideoViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.temp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCellCollectionView.identifier, for: indexPath) as? VideoCellCollectionView else {return UICollectionViewCell()}
        cell.cellConfig(with: vm.temp[indexPath.row])
        return cell
                
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoCollectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //vm.updateStatus(index: indexPath.row)
        self.vm.clickStatus(index: indexPath.row)
       // self.videoCollectionView.reloadData()
        print(indexPath.row)
    }
    
}
