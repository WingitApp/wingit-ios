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
                                    HStack{
                                    UserRow(
                                      urlString: user.profileImageUrl ?? "",
                                      userDisplayName: user.displayName ?? "",
                                      username: user.username ?? "")
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

