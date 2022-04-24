//
//  EndPoints.swift
//  Friends
//
//  Created by Tanvir Alam on 24/4/22.
//

import Foundation

enum EndPoint {
    case Base, HowManyFriends(Int)
}

class EndPointSouce {
    
    static func getEndPoint(type:EndPoint) -> String {
        switch type {
        case .Base:
            return "https://randomuser.me/api/"
        case .HowManyFriends(let numberOfFriends):
            return "?results=\(numberOfFriends)"
        }
    }
    
//    static var basicHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
//
//    static func CustomHeaders() -> [String:String] {
//        //let token = CoreDataManager.shared.getUserLoken()?.token ?? ""
//        //let CustomHeaders = ["Authorization":"Bearer \(token)",
//                             //"Content-Type":"application/json",
//                             //"Accept":"application/json"]
//        let CustomHeaders = ["Content-Type":"application/json",
//                             "Accept":"application/json"]
//        return CustomHeaders
//    }
//
//    static func MultiPartCustomHeaders() -> [String:String] {
//        //let token = CoreDataManager.shared.getUserLoken()?.token ?? ""
//        let multiPartCustomHeaders = [//"Authorization":"Bearer \(token)",
//                                      "Content-Type":"multipart/form-data",
//                                      "Accept":"application/json"]
//        return multiPartCustomHeaders
//    }
    
}
