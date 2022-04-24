//
//  WebServices.swift
//  Friends
//
//  Created by Tanvir Alam on 24/4/22.
//

import Foundation


enum NetworkingError:Error{
    case nodataAvailable
    case invalidURL
    case canNotProcessData
    case encodingError
    case statusCodeIsNotOkay
}

class FriendsWebServices{
    static let shared = FriendsWebServices()
    private init(){}
    private let session = URLSession.shared
    
    //Get Method Async throws NEW
    func fetchFriends() async throws -> FriendsModel {
        
        let urlStirng = EndPointSouce.getEndPoint(type: .Base) + EndPointSouce.getEndPoint(type: .HowManyFriends(10))
        
        print(urlStirng)
        guard let url = URL(string: urlStirng) else {
            throw NetworkingError.invalidURL
        }
        
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,_) = try await URLSession.shared.data(for: request)
        
        var friendsModel : FriendsModel!
        
        do {
            friendsModel = try JSONDecoder().decode(FriendsModel.self, from:data)
        }catch{
            throw NetworkingError.canNotProcessData
        }
        
        return friendsModel
    }
    
    //Alternative of async throws OLD PROCEDURE
    func getFriends(completion: @escaping (Result<FriendsModel,NetworkingError>)->Void){
        
        let urlStirng = EndPointSouce.getEndPoint(type: .Base) + EndPointSouce.getEndPoint(type: .HowManyFriends(10))
        
        print(urlStirng)
        guard let url = URL(string: urlStirng) else {
            completion(.failure(.invalidURL))
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else{
                completion(.failure(.nodataAvailable))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Response is nil")
                return
            }
            print(response.statusCode)
            print(jsonData)
            if response.statusCode == 200{
                do{
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(FriendsModel.self, from: jsonData)
                    completion(.success(responseObject))
                }catch{
                    print("Error \(error)")
                    completion(.failure(.canNotProcessData))
                }
            }else{
                completion(.failure(.statusCodeIsNotOkay))
            }
            
        }
        
        dataTask.resume()
    }
}
