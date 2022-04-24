//
//  HomeView.swift
//  Friends
//
//  Created by Tanvir Alam on 24/4/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    var body: some View {
        
        if vm.message.isEmpty{
            List(vm.friends,id:\.id) { friend in
                NavigationLink(destination: FriendDetailCard(friend: friend)) {
                    FriendCard(title: friend.nameTitle, firstName: friend.firstName, lastName: friend.lastName, imageUrl: friend.largeImageURL, country: friend.country)
                        .padding()
                }
            }.navigationTitle("Friends")
        }else{
            messsageCard
        }
    }
    
    var messsageCard:some View{
        VStack{
            Text(vm.message)
                .foregroundColor(.black)
            ProgressView()
        }.padding(30)
            .frame(width: 600, height: 100, alignment: .center)
            .background(.gray).opacity(0.7)
            .cornerRadius(10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


