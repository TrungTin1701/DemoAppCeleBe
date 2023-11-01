//
//  VideoViewModel.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 01/11/2023.
//

import Foundation
import RxSwift
import RxCocoa

class VideoViewModel{
    var temp : [Video] = []
    var data = PublishSubject<[Video]>()
    func getdata(){
        self.temp = Video.dataVideo
        self.data.onNext(temp)
        self.data.onCompleted()
    }
    func changeStatusVideo(newLike: Int, newCmt: Int , newShare : Int, index : Int){
        self.temp[index].like = newLike
        self.temp[index].comment = newCmt
        self.temp[index].share = newShare
    }
    func clickStatus(index :Int){
        self.temp[index].statusLike.toggle()
    }
    func updateStatus(index :Int){
        for (i, _) in self.temp.enumerated() {
            self.temp[i].statusLike = (i == index)
        }
    }
    
}
