//
//  UserView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI
import URLImage

struct UsersView: View {
    
    @ObservedObject var usersViewModel = UsersViewModel()

    var body: some View {
                VStack {
                    SearchBar(
                        text: $usersViewModel.searchText,
                        placeholder: "Search for users",
                        onSearchButtonChanged: usersViewModel.searchTextDidChange)

                    List {
                        if !usersViewModel.isLoading {

                                ForEach(usersViewModel.users, id: \.id) { user in
                                  NavigationLink(destination: ProfileView(userId: nil, user: user)) {
                                        HStack {
                                            URLImageView(urlString: user.profileImageUrl)
                                              .clipShape(Circle())
                                              .frame(width: 40, height: 40)
                                              .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                  .stroke(Color.gray, lineWidth: 0.5)
                                              )
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                             Text(user.displayName ?? "")
                                              .font(.headline).bold()
                                              Text("@\(user.username ?? "")")
                                                .font(.subheadline)
                                                .foregroundColor(.wingitBlue)
                                            }
                                        }
                               }
                                    .padding(10)
                            }
                        }
                   
                   
                    } 
                }
                .navigationBarTitle(Text("Search"), displayMode: .inline)
                .onAppear{
                    logToAmplitude(event: .searchForFriends)
                }
    }
}

