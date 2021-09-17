//
//  ImageView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/13/21.
//

import SwiftUI
import URLImage

struct ImageView: View {
  var post: Post
  @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        
        ZStack{
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
            }
            Color.black
                .ignoresSafeArea()
            
            URLImage(URL(string: post.mediaUrl)!,
                  content: {
                      $0.image
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                  })
        }

    }
}

struct profileImageView: View {

  @ObservedObject var userProfileViewModel = UserProfileViewModel()
  @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        
        ZStack{
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
            }
            Color.black
                .ignoresSafeArea()
            
            URLImage(URL(string: userProfileViewModel.user.profileImageUrl ?? "")!,
                  content: {
                      $0.image
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                  })
        }

    }
}
