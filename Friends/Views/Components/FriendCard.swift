//
//  FriendCard.swift
//  Friends
//
//  Created by Tanvir Alam on 24/4/22.
//

import SwiftUI

struct FriendCard: View {
    var title:String
    var firstName:String
    var lastName:String
    var imageUrl:String
    var country:String
    
    var body: some View {
        
        HStack(alignment:.center, spacing: 10){
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    
            } placeholder: {
                Color.purple.opacity(0.1)
            }
            .frame(width: 100, height: 100)
            .cornerRadius(20)
            .padding(10)
            VStack(alignment:.leading, spacing:10){
                Text("\(title) \(firstName) \(lastName)")
                    .font(.title)
                    .fontWeight(.bold)
                Text(country)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        
        
    }
}

struct FriendCard_Previews: PreviewProvider {
    static var previews: some View {
        FriendCard(title: "MR", firstName: "Tanvir", lastName: "Alam", imageUrl: "https://www.google.com", country: "Bangladesh")
    }
}
