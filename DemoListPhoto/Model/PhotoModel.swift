//
//  PhotoModel.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 23/10/2023.
//

import Foundation


struct PhotoModel : Codable {
    let id : String
    let alt_description : String
    let description : String?
    let urls : Urls
    let likes : Int
    let links : Links
    let user : User?
    	
}



struct Urls : Codable {
    let raw : String
    let full : String
    let small : String
}

struct Links : Codable {
   
    let html  : String
    let download : String
    
}

struct User : Codable {
    let name : String
    let bio : String?
    let profile_image : ProfileImage
    let social : Social?
}

struct ProfileImage: Codable {
    let small : String
    let large : String
    let medium : String
}

struct Social : Codable {
    let instagram_username : String?
    let portfolio_url : String?
}
