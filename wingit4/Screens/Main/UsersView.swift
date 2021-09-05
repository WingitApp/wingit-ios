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
                    SearchBar(text: $usersViewModel.searchText, onSearchButtonChanged: usersViewModel.searchTextDidChange)

                    List {
                        if !usersViewModel.isLoading {

                                ForEach(usersViewModel.users, id: \.id) { user in
                                    NavigationLink(destination: UserProfileView(user: user)) {
                                        HStack {
                                        URLImage(URL(string: user.profileImageUrl)!,
                                        content: {
                                            $0.image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(Circle())
                                        }).frame(width: 50, height: 50)
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                             Text(user.displayName()).font(.headline).bold()
                                                Text(user.bio ?? "").font(.subheadline)
                                            }
                                          
                                        }.padding(10)
                               }
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

