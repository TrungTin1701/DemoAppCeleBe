//
//  PhotoViewModel.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 23/10/2023.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

    class PhotoViewModel {
        
       var items = PublishSubject<[PhotoModel]>()
       private let apiservice : APIService = APIService()
       public func getPhotoData(){
           apiservice.handleAPI(API_Link.getContentApi,responseType: [PhotoModel].self){ [weak self]
                (result : Result<[PhotoModel],ErrorApiCall>) in
                switch result {
                case .success(let photoModels) :
                    for photoModel in photoModels {
                        print("Description is \(photoModel.user?.name ?? "Nothing")")
                    }
                    self?.items.onNext(photoModels)
                    self?.items.onCompleted()
                case .failure(let error) :
                    print("Request Failure with Error : \(error)")
                    
                }
           
            }
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
