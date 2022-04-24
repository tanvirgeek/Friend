//
//  HomeViewModel.swift
//  Friends
//
//  Created by Tanvir Alam on 24/4/22.
//

import Foundation
import SwiftUI

class HomeViewModel:ObservableObject{
    
    @Published var friends = [FriendViewModel]()
    @Published var isLoading = true
    @Published var message = ""
    
    init(){
        self.getFriends()
        
//        Task {
//            await self.fetchFriend()
//        }
    }
    
    // OLD way
    private func getFriends() {
        isLoading = true
        message = "Loading.."
        //New Async Awat
        
        FriendsWebServices.shared.getFriends {[weak self] result in
            switch result{
            case .success(let result):
                DispatchQueue.main.async {
                    self?.friends = result.results.map(FriendViewModel.init)
                    self?.isLoading = false
                    self?.message = ""
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    switch error{
                    case .nodataAvailable:
                        print("Error: No data Available Check internet connection: \(error.localizedDescription)")
                        self?.message = "Error: No data Available: Check internet connection and restart the app"
                    case .invalidURL:
                        print("Error: invalid url: \(error.localizedDescription)")
                        self?.message = "Error: invalid url:"
                    case .canNotProcessData:
                        print("Error: Can Not Process Data: \(error.localizedDescription)")
                        self?.message = "Error: Can Not Process Data:"
                    case .encodingError:
                        print("Error: Encoding Error: \(error.localizedDescription)")
                    case .statusCodeIsNotOkay:
                        self?.message = "Error: Something wrong, status code not okay"
                    }
                    self?.isLoading = false
                }
            }
        }
    }
    
    // NEW AYNCH
    private func fetchFriend() async{
        isLoading = true
        message = "Loading.."
        do{
            let friends = try await FriendsWebServices.shared.fetchFriends()
            DispatchQueue.main.async {
                self.friends = friends.results.map(FriendViewModel.init)
                self.isLoading = false
                self.message = ""
            }
        }catch(let error){
            DispatchQueue.main.async {
                if let error = error as? NetworkingError {
                    switch error{
                    case .nodataAvailable:
                        print("Error: No data Available Check internet connection: \(error.localizedDescription)")
                        self.message = "Error: No data Available: Check internet connection"
                    case .invalidURL:
                        print("Error: invalid url: \(error.localizedDescription)")
                        self.message = "Error: invalid url:"
                    case .canNotProcessData:
                        print("Error: Can Not Process Data: \(error.localizedDescription)")
                        self.message = "Error: Can Not Process Data:"
                    case .encodingError:
                        print("Error: Encoding Error: \(error.localizedDescription)")
                    case .statusCodeIsNotOkay:
                        self.message = "Error: Something wrong, status code not okay"
                    }
                    self.isLoading = false
                }else{
                    print("Error")
                }
                
            }
        }
    }
    
   
}

//This is a viewmodel for a single friend. We can modify the incomming data here
class FriendViewModel:Identifiable{
    var id = UUID()
    var friend:ResultModel
    init(friend:ResultModel){
        self.friend = friend
    }
    var nameTitle:String {
        return friend.name.title
    }
    
    var firstName: String{
        return friend.name.first
    }
    var lastName:String{
        return friend.name.last
    }
    var email:String{
        return friend.email
    }
    var phone:String{
        return friend.phone
    }
    var cell:String{
        return friend.cell
    }
    var street:String{
        return friend.location.street.name
    }
    var streetNumber:Int{
        return friend.location.street.number
    }
    var city:String{
        return friend.location.city
    }
    var state:String{
        return friend.location.state
    }
    var country:String{
        return friend.location.country
    }
    var largeImageURL:String{
        return friend.picture.large
    }
    var mediumImageURL:String{
        return friend.picture.medium
    }
    var smallImageURL:String{
        return friend.picture.thumbnail
    }
}
