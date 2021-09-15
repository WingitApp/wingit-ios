//
//  ProfileFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 9/13/21.
//

import SwiftUI

struct ProfileFeed: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel

    var body: some View {
        
    
//        if profileViewModel.emptyState == true {
//            Image("logo")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 40, height: 40)
//            Text("No Asks! Anything you need to ask?") .font(.system(size: 12))
//                .fontWeight(.bold)
//        } else
        if profileViewModel.showOpenPosts && profileViewModel.openPosts.count != 0 {
        LazyVStack {
          ForEach(Array(profileViewModel.openPosts.enumerated()), id: \.element) { index, post in
              AskCard(
                post: post,
                isProfileView: true,
                index: index
              )
            }
        }
        .onAppear {
          self.profileViewModel.openPosts.sort {
            $0.date > $1.date
          }
        }
        } else if profileViewModel.closedPosts.count != 0 {
        LazyVStack {
          ForEach(Array(profileViewModel.closedPosts.enumerated()), id: \.element) { index, post in
              AskCard(
                post: post,
                isProfileView: true,
                index: index
              )
            }
        }
        .onAppear {
          self.profileViewModel.closedPosts.sort {
            $0.date > $1.date
          }
        }
        } else if profileViewModel.openPosts.count == 0 {
            Image("logo")
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 40, height: 40)
               .padding(.top, 30)
           Text("No Asks! Anything you need to ask?")
               .font(.system(size: 12))
               .fontWeight(.bold)
               .font(.system(size: 12))
               .foregroundColor(.gray)
               .padding(.top, 25)
        } else {
            Image("logo")
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 40, height: 40)
               .padding(.top, 30)
           Text("No Closed Asks atm.")
               .font(.system(size: 12))
               .fontWeight(.bold)
               .font(.system(size: 12))
               .foregroundColor(.gray)
               .padding(.top, 25)
        }
    }
}

