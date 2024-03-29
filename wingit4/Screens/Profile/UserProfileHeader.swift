//
//  UserProfileHeader.swift
//  wingit4
//
//  Created by Daniel Yee on 9/11/21.
//


import SwiftUI
import URLImage
struct UserProfileHeader: View {
 //   @EnvironmentObject var session: SessionStore
    var user: User?
    var openCount: Int
    var closedCount: Int
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
    @State var viewingClosedPosts: Bool = false
    
    var body: some View {
        
            if user != nil {
                VStack(alignment:.center) {
                    HStack{
                      VStack {
                          Text("\(openCount)")
                            .font(.headline)
                            .foregroundColor(userProfileViewModel.showOpenPosts ? .wingitBlue : Color.black)
                          Text("Open")
                            .font(.subheadline)
                            .foregroundColor(userProfileViewModel.showOpenPosts ? .wingitBlue : .gray)
                      }
                      .padding(10)
                      .onTapGesture {
                        self.userProfileViewModel.showOpenPosts = true
                      }
                      VStack{
                        Text("\(closedCount)")
                          .font(.headline)
                            .foregroundColor(userProfileViewModel.showOpenPosts ? Color.black : .wingitBlue)
                        Text("Closed")
                          .font(.subheadline)
                            .foregroundColor(userProfileViewModel.showOpenPosts ? .gray : .wingitBlue)

                      }.padding(10)
                      .onTapGesture {
                        self.userProfileViewModel.showOpenPosts = false
                      }
                    }
            
            }
            .sheet(isPresented: $viewingClosedPosts, content: {
                UserProfileClosedPostsView(user: user!)})
        }
    }
}


