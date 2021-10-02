//
//  ProfileDetailView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/16/21.
//

import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
          VStack(alignment: .center, spacing: 0){
            Text("Hi I love to eat, jump, laugh, play the guitar, think, talk, and do nothing. If you want to talk about these things please hit me up. :)")
              .fontWeight(.regular)
              .font(Font.footnote)
              .foregroundColor(Color.black.opacity(0.7))
              .fixedSize(horizontal: false, vertical: true)
            
          }
          .padding(.top, 5)
          ProfileUserLinks()
          ProfilePostsTab(isOwnProfile: true)
          .padding(.top, 20)
          Divider()
            .padding(.leading, -15) // needed to offset
            .padding(.trailing, -15)
          ScrollView {
            ProfileFeed()
              .padding([.vertical])
              .background(Color.backgroundGray)
              
          }
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
