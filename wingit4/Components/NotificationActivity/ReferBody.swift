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
    
// Menu
@StateObject var askCardViewModel = AskCardViewModel()
@StateObject var askMenuViewModel = AskMenuViewModel()
@StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
// Comment
@StateObject var commentViewModel = CommentViewModel()
@StateObject var referViewModel = ReferViewModel()
@StateObject var commentInputViewModel = CommentInputViewModel()
// Like
@StateObject var footerCellViewModel = FooterCellViewModel()
    
  @Binding var referral: Referral
  @Binding var post: Post

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
            VStack {
                HStack {
                    URLImageView(urlString: referral.ask?.avatar)
                      .clipShape(Circle())
                      .frame(width: 30, height: 30)
                      .overlay(
                        RoundedRectangle(cornerRadius: 100)
                          .stroke(Color.gray, lineWidth: 1)
                      )
                        VStack(alignment: .leading) {
                            Text(referral.ask?.username ?? "")
                              .font(.subheadline).bold()
                          
                        }.padding(.top, 5)
                        Spacer()
                  //  Image(systemName: "ellipsis")
                    }.padding(.trailing, 15).padding(.leading, 15)

                PostText(ask: referral.ask)
            }
            .padding(.top, 15).padding(.bottom, 25)
            .frame(width: UIScreen.main.bounds.width - 60)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.3))

        }
        .buttonStyle(PlainButtonStyle())
        .background(Color.lightGray.opacity(0.1))
        .padding(.bottom, 10)
        
    }
}

import SwiftUI

struct PostText: View {
    var ask: Post?
    var body: some View {
        HStack{

            VStack(alignment: .leading, spacing: 10){
                Text(ask?.caption ?? "")
                  .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal)
            Spacer(minLength: 0)
//                Image("photo2").resizable().scaledToFill()
//                               .frame(width: 200, height: 250).clipped()
        }
    }
}


