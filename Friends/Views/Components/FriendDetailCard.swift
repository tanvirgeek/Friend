//
//  SwiftUIView.swift
//  Friends
//
//  Created by Tanvir Alam on 24/4/22.
//

import SwiftUI

struct FriendDetailCard: View {
    var friend:FriendViewModel
    @State private var mailData = ComposeMailData(subject: "A subject",
                                                    recipients: ["i.love@swiftuirecipes.com"],
                                                    message: "Here's a message",
                                                    attachments: [AttachmentData(data: "Some text".data(using: .utf8)!,
                                                                                 mimeType: "text/plain",
                                                                                 fileName: "text.txt")])
    @State private var showMailView = false
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading, spacing: 10){
                VStack{
                    AsyncImage(url: URL(string: friend.largeImageURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.purple.opacity(0.1)
                    }
                    .cornerRadius(20)
                    .padding(16)
                    .frame(height: 600)
                }
                
                VStack(alignment:.leading, spacing:10){
                    Text("\(friend.nameTitle) \(friend.firstName) \(friend.lastName)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Address: \(friend.street)")
                    Text("City: \(friend.city)")
                    Text("State \(friend.state)")
                    Text("Country: \(friend.country)")
                    
                    //Sending email On Tap, Test it in real device
                    Text("Email: \(friend.email) (Tap me to send email in real device)")
                        .onTapGesture(count: 1) {
                            print("I am tapped")
                            showMailView.toggle()
                        }
                        .disabled(!MailView.canSendMail)
                        .sheet(isPresented: $showMailView) {
                              MailView(data: $mailData) { result in
                                print(result)
                            }
                        }
                    
                    Text("Cell: \(friend.cell)")
                }.foregroundColor(Color.black)
                .font(.title2)
                .padding()
                Spacer()
            }
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .navigationTitle("Friend Detail")
        }
    }
}

struct FriendDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailCard(friend:  FriendViewModel(friend: ResultModel(name: NameModel(title: "MD", first: "Tanvir", last: "Alam"), location: LocationModel(street: StreetModel(number: 12343, name: "BosePara"), city: "Dhaka", state: "California", country: "Bangladesh"), email: "Tanvirgeek@gmail.com", phone: "01784818346", cell: "09394984", picture: PictureModel(large: "https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg", medium: "https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg", thumbnail: "https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg"))))
    }
}

