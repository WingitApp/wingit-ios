//
//  ImageView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/13/21.
//

import SwiftUI
import URLImage

struct ImageView: View {
  @Binding var post: Post?
  @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        
        ZStack{
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
            }
            Color.black
                .ignoresSafeArea()
            
            URLImageView(urlString: post?.mediaUrl)
              .aspectRatio(contentMode: .fit)
        }

    }
}

struct profileImageView: View {
   // var user: User
  @EnvironmentObject var userProfileViewModel: UserProfileViewModel
  @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        
        ZStack{
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
            }
            Color.black
                .ignoresSafeArea()
            
          URLImage(URL(string: userProfileViewModel.user.profileImageUrl ?? "")!) {
                      $0
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                  }
        }

    }
}
