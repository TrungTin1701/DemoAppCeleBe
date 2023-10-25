//
//  APIService.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 23/10/2023.
//

import Foundation
import Alamofire

enum API_Link {
    static let getContentApi = "https://api.unsplash.com/photos/?client_id=GKZqbm-oV8idWbDCAN3z0cJphD-Lq5D1KhA5N3edqys"
    
}
//func handleAPI(_ link: String){
//    guard let url = URL(string: link) else {
//        return
//    }
//    if !NetworkReachabilityManager()!.isReachable {
//        print("No Intenet Connection!!!")
//    }
//    AF.request(url).responseDecodable(of: [PhotoModel].self) { (response) in
//        switch response.result {
//        case .success ( let photoModel ) :
//            print(photoModel)
//        
//        case .failure(let error) :
//            print("Request failure with Error : \(error)")
//        
//        }
//        
//    }
//}


func handleAPI<T: Decodable>(_ link: String, responseType: T.Type, completionHandler: @escaping (Result<T, AFError>) -> Void) {
    guard let url = URL(string: link) else {
        return
    }

    if !NetworkReachabilityManager()!.isReachable {
        print("No Internet Connection!!!")
        return
    }

    AF.request(url).responseDecodable(of: T.self) { (response) in
        completionHandler(response.result)
    }
}
