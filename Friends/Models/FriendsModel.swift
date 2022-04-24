//
//  FriendsModel.swift
//  Friends
//
//  Created by Tanvir Alam on 24/4/22.
//

import Foundation

struct FriendsModel:Codable{
    var results:[ResultModel]
}

struct ResultModel:Codable {
    var name:NameModel
    var location: LocationModel
    var email:String
    var phone :String
    var cell:String
    var picture:PictureModel
}
struct NameModel:Codable{
    var title :String
    var first:String
    var last:String
}
struct LocationModel:Codable {
    var street :StreetModel
    var city :String
    var state :String
    var country:String
}
struct StreetModel:Codable {
    var number :Int
    var name :String
}
struct PictureModel:Codable {
    var large:String
    var medium:String
    var thumbnail:String
    
}
