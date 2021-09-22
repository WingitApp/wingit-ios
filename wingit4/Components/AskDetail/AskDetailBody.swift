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
  @Binding var post: Post

    var body: some View {
      VStack(alignment: .leading) {

        HStack(alignment: .top) {
          URLImageView(urlString: post.avatar)
            .clipShape(Circle())
            .frame(width: 35, height: 35, alignment: .center)
            .overlay(
              RoundedRectangle(cornerRadius: 100)
                .stroke(Color.gray, lineWidth: 1)
            )
          VStack(alignment: .leading){
            Text(post.username)
              .font(.subheadline)
              .fontWeight(.bold)
            TimeAgoStamp(date: post.date)
              .font(.caption2)
          }
          Spacer()
          AskDoneToggle(
            post: $post,
            showLabel: true
          ) // rename later
        }
        .padding(.bottom, 15)
        
        HStack{
          Text(post.caption)
            .fontWeight(.medium)
            .modifier(BodyStyle())
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, 5)
        
       
      if post.mediaUrl != "" {
        Button(action: {
            withAnimation(.easeInOut){
              askCardViewModel.isImageModalOpen.toggle()
            }
        }, label: {
          URLImage(URL(string: post.mediaUrl)!,
            content: {
                $0.image
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
            })
            
            .frame(width: UIScreen.main.bounds.width - 37, height: 275)
            .cornerRadius(15)
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 0.2)
                )
            })
         }
      }
      .padding(15)
    }
}
