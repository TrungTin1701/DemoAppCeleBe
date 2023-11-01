//
//  ExpandedCellViewController.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 31/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
class ExpandedTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myExpandedTableView: UITableView!
    private var bag = DisposeBag()
    private var vm = CellDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Expanded Cell"
        // Do any additional setup after loading the view.

        setupCell()
        bindingData()
        vm.getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.temp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandedTableViewCell", for: indexPath) as? ExpandedTableViewCell
        else {return UITableViewCell()}
        cell.config(model: vm.temp[indexPath.row])
        cell.cellTappedClosure = {
            [weak self ] indexPath,status in
            self?.vm.changeStatus(status: status, index: indexPath)
            print("Change Status")
        }
       // cell.delegate = self
        return cell
    }
    
    func setupCell() {
        myExpandedTableView.separatorStyle = .none
        myExpandedTableView.register(UINib(nibName: "ExpandedTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpandedTableViewCell")
        myExpandedTableView.estimatedRowHeight = UITableView.automaticDimension
        myExpandedTableView.rowHeight = UITableView.automaticDimension
        self.myExpandedTableView.delegate = self
        self.myExpandedTableView.dataSource = self
    }
    
    func bindingData() {
        vm.data.subscribe { [weak self] model in
            guard let self = self else {return }
            self.myExpandedTableView.reloadData()
            print("Binding Data")
        }.disposed(by: self.bag)
    }
   
}

extension ExpandedTableViewController: CellTapped {
   
    func changeStatus(atIndex index: Int, status: Bool) {
     //   vm.changeStatus(status: status, index: index)
    }
}

