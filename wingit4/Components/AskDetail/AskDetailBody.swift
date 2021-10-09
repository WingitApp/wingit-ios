//
//  AskDetailBody.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import URLImage


struct AskDetailBody: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Binding var post: Post?

    var body: some View {
      VStack(alignment: .leading) {

        HStack(alignment: .top) {
         NavigationLink(
            destination: ProfileView(userId: post?.ownerId, user: nil),
            label: {
                URLImageView(urlString: post?.avatar ?? "")
                  .clipShape(Circle())
                  .frame(width: 35, height: 35, alignment: .center)
                  .overlay(
                    RoundedRectangle(cornerRadius: 100)
                      .stroke(Color.gray, lineWidth: 1)
                  )
                VStack(alignment: .leading){
                  Text(post?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.bold)
                  TimeAgoStamp(date: post?.date ?? 0)
                    .font(.caption2)
                }
            }).buttonStyle(PlainButtonStyle())
          .onTapGesture {
            Haptic.impact(type: "soft")
          }
         
          Spacer()
          AskDoneToggle(
            post: $post,
            showLabel: true
          ) // rename later
        }
        .padding(.bottom, 15)
        
        HStack{
          Text(post?.caption ?? "")
            .fontWeight(.medium)
            .modifier(BodyStyle())
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, 5)
        
       
      if post?.mediaUrl != "" {
        Button(action: {
            withAnimation(.easeInOut){
              askCardViewModel.isImageModalOpen.toggle()
            }
        }, label: {
          URLImageView(urlString: post?.mediaUrl)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 37, height: 275)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0.2)
                )
            })
          .padding(.top, 10)
          .padding(.bottom, 10)
         }
      }
      .padding(15)
    }
}
