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
                        Text("\(openCount)").font(.headline)
                        Text("Open").font(.subheadline).foregroundColor(.gray)
                    }.padding(10)
                    NavigationLink(
                        destination: PersonalClosedPostsView(user: user!),
                        label: {
                            VStack{
                            Text("\(closedCount)").font(.headline).foregroundColor(Color("bw"))
                            Text("Closed").font(.subheadline).foregroundColor(.gray)
                            }.padding(10)
                        })
                    }
            
            }
            .sheet(isPresented: $viewingClosedPosts, content: {
                UserProfileClosedPostsView(user: user!)})
        }
    }
}


