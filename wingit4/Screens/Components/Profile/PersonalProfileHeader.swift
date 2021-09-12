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
                        Text("\(profileViewModel.openPosts.count)").font(.headline)
                        Text("Open").font(.subheadline).foregroundColor(.gray)
                    }.padding(10)
                    NavigationLink(
                        destination: PersonalClosedPostsView(user: user!),
                        label: {
                            VStack{
                            Text("\(profileViewModel.closedPosts.count)").font(.headline).foregroundColor(Color("bw"))
                            Text("Closed").font(.subheadline).foregroundColor(.gray)
                            }.padding(10)
                        })
                    }
            
            }
            .sheet(isPresented: $viewingClosedPosts, content: {
                PersonalClosedPostsView(user: user!)})
        }
    }
}

