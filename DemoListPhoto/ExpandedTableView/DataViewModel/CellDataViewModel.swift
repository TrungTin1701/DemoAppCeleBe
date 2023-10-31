//
//  CellDataViewModel.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 31/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

class CellDataViewModel {
    var data = PublishSubject<[CellDataModel]>()
    var temp = [CellDataModel]()
    
    public func getData(){
        self.temp = CellDataModel.mockedData
        self.data.onNext(temp)
        self.data.onCompleted()
    }
    
    public func changeStatus(status : Bool, index : Int){
        self.temp[index].isExpanded = status
    }
}
