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
enum ErrorApiCall : Error{
    case ConnectionError(NSError?)
    case ServerError(statusCode:Int, message : String?)
    case JSONError(NSError?)
    case URLNotValid(NSError?)
    case Timeout
}


import Alamofire
class APIService {
    
    func handleAPI<T: Decodable>(_ link: String, responseType: T.Type, completionHandler: @escaping (Result<T, ErrorApiCall>) -> Void) {
        guard let url = URL(string: link) else {
            completionHandler(.failure(ErrorApiCall.ConnectionError(nil)))
            return
        }
        
        if !NetworkReachabilityManager()!.isReachable {
            completionHandler(.failure(ErrorApiCall.ConnectionError(nil)))
            return
        }
        
        let requestTimeout: TimeInterval = 5 // 5 seconds
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = requestTimeout

        AF.request(urlRequest).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                if let afError = error as? AFError {
                    switch afError {
                    case .responseValidationFailed:
                        let statusCode = afError.responseCode ?? 0
                        let message = afError.errorDescription
                        completionHandler(.failure(ErrorApiCall.ServerError(statusCode: statusCode, message: message)))
                    case .sessionTaskFailed(let sessionError):
                        if let urlError = sessionError as? URLError, urlError.code == .timedOut {
                            completionHandler(.failure(ErrorApiCall.Timeout))
                        } else {
                            completionHandler(.failure(ErrorApiCall.ConnectionError(nil)))
                        }
                    default:
                        completionHandler(.failure(ErrorApiCall.ConnectionError(nil)))
                    }
                } else {
                    completionHandler(.failure(ErrorApiCall.ConnectionError(error as NSError?)))
                }
            }
        }
    }
}
