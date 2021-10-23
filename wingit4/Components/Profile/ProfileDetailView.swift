//
//  ProfileDetailView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/16/21.
//

import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    @EnvironmentObject var profileViewModel: SessionStore // moved user metadata to sessionStore
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
  
    var user: User?
    var isOwnProfile: Bool
  
    var body: some View {
        VStack(alignment: .leading, spacing: 0){

          ProfileUserBio(user: user, isOwnProfile: isOwnProfile)
          ProfileUserLinks(user: user, isOwnProfile: isOwnProfile)
          ProfilePostsTab(isOwnProfile: isOwnProfile)
          .padding(.top, 20)
          Divider()
            .padding(.leading, -15) // needed to offset
            .padding(.trailing, -15)
          ScrollView {
            ProfileFeed(isOwnProfile: isOwnProfile) // add switch
              .padding([.vertical])
              
          }
          .background(Color.backgroundGray)
          .padding(.leading, -15) // needed to offset
          .padding(.trailing, -15)
        
        }
      
        .padding([.horizontal])


    }
}

//struct LinkCard: View {
//
//    var body: some View {
//
//
//        HStack{
//                Image("airbnb")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 30, height: 30)
//                    .padding()
//            Text("My airbnb")
//                .foregroundColor(.pink)
//                .bold()
//                .padding(.trailing)
//        }
//        .background(Color.white)
//        .cornerRadius(8)
//        .overlay(
//          RoundedRectangle(cornerRadius: 8)
//            .stroke(Color.borderGray, lineWidth: 1)
//        )
//        .padding(
//          EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0)
//        )
//        .clipped()
//        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
//
//        HStack{
//                Image("spotify")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 30, height: 30)
//                    .padding()
//            Text("My spotify")
//                .foregroundColor(.green)
//                .bold()
//                .padding(.trailing)
//        }
//        .background(Color.white)
//        .cornerRadius(8)
//        .overlay(
//          RoundedRectangle(cornerRadius: 8)
//            .stroke(Color.borderGray, lineWidth: 1)
//        )
//        .padding(
//          EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0)
//        )
//        .clipped()
//        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
//
//    }
//}
