//
//  PersonalProfileHeader.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI
import URLImage
struct PersonalProfileHeader: View {
 //   @EnvironmentObject var session: SessionStore
    var user: User?
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var viewingClosedPosts: Bool = false
    
    var body: some View {
        
            if user != nil {
                VStack(alignment:.center) {
                    HStack{
                    VStack {
                        Text("\(profileViewModel.openPosts.count)")
                          .font(.headline)
                            .foregroundColor(profileViewModel.showOpenPosts ? Color(.systemTeal) : Color.black)
                        Text("Open")
                          .font(.subheadline)
                          .foregroundColor(profileViewModel.showOpenPosts ? Color(.systemTeal) : .gray)
                    }
                    .padding(10)
                    .onTapGesture {
                      profileViewModel.showOpenPosts = true
                    }
                      VStack{
                      Text("\(profileViewModel.closedPosts.count)")
                        .font(.headline)
                        .foregroundColor(profileViewModel.showOpenPosts ?  Color.black : Color(.systemTeal))
                      Text("Closed")
                        .font(.subheadline)
                        .foregroundColor(profileViewModel.showOpenPosts ? .gray : Color(.systemTeal))
                      }
                      .padding(10)
                      .onTapGesture {
                        profileViewModel.showOpenPosts = false
                      }
            
            }
            .sheet(isPresented: $viewingClosedPosts, content: {
                PersonalClosedPostsView(user: user!)})
        }
    }
}

}
