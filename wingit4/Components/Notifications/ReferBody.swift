//
//  ReferBody.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/2/21.
//

import SwiftUI
import URLImage
import FirebaseAuth



struct ReferBody: View {
@EnvironmentObject var referViewModel: ReferViewModel

// Menu
@StateObject var askCardViewModel = AskCardViewModel()
@StateObject var askMenuViewModel = AskMenuViewModel()
@StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
// Comment
@StateObject var commentViewModel = CommentViewModel()
@StateObject var commentInputViewModel = CommentInputViewModel()
// Like
@StateObject var footerCellViewModel = FooterCellViewModel()
    
  @Binding var referral: Referral
  @Binding var post: Post?

    var body: some View {
        NavigationLink(
            destination: AskDetailView(post: $post)
                .environmentObject(askCardViewModel)
                .environmentObject(askMenuViewModel)
                .environmentObject(askDoneToggleViewModel)
                .environmentObject(commentViewModel)
                .environmentObject(commentInputViewModel)
                .environmentObject(footerCellViewModel)
        ) {
          VStack(alignment: .leading) {
            AskCard(
              post: post,
              isProfileView: false,
              index: 1
              
            )
          }
          .navigationBarTitle("")
          .navigationBarHidden(true)
          .edgesIgnoringSafeArea(.top)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

import SwiftUI

struct PostText: View {
    var ask: Post?
    var body: some View {
        HStack{

            VStack(alignment: .leading, spacing: 10){
                Text(ask?.caption ?? "")
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
            Spacer(minLength: 0)
//                Image("photo2").resizable().scaledToFill()
//                               .frame(width: 200, height: 250).clipped()
        }
    }
}


