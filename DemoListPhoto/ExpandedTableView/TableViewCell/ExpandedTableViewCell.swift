//
//  ExpandedTableViewCell.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 31/10/2023.
//

import UIKit
 
protocol CellTapped : AnyObject {
    func changeStatus(atIndex index : Int ,status : Bool)
}

class ExpandedTableViewCell: UITableViewCell {

    @IBOutlet weak var myTitleLabel: UILabel!
    
    @IBOutlet weak var myIcon: UIImageView!
    
    @IBOutlet weak var sectionView: UIView!
    
    @IBOutlet weak var detailText: UILabel!
    
    var isShow : Bool = false
    
    weak var delegate : CellTapped?
    
    var cellTappedClosure: ((Int, Bool) -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
        detailText.isHidden = !isShow
        let tapSectionView = UITapGestureRecognizer(target: self, action: #selector(sectionTapped))
        sectionView.addGestureRecognizer(tapSectionView)
    }

    @objc func sectionTapped(){
        isShow.toggle()
        updateCollapseState()
        if let tableView = superview as? UITableView, let indexPath = tableView.indexPath(for: self) {
            delegate?.changeStatus(atIndex: indexPath.row, status: isShow)
            cellTappedClosure?(indexPath.row,isShow)
            }

        
    }
    
    private func updateCollapseState() {
        guard let tableView = self.superview as? UITableView else { return }
        tableView.beginUpdates()
        detailText.isHidden = !isShow
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.myIcon.transform = self!.isShow == false ? .identity : .init(rotationAngle: 135)
            tableView.endUpdates()
        }
    }
    
    func config(model: CellDataModel) {
        myIcon.image = UIImage(systemName: model.iconName)
        detailText.text = model.description
        myTitleLabel.text = model.title
        isShow = model.isExpanded
        updateCollapseState()
    }
    func updateStatus(_ status : Bool){
        self.isShow = status
    }
}

