//
//  AskDetailHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import URLImage


struct AskDetailHeader: View {
  @Binding var post: Post
  
    var body: some View {
      HStack {
        URLImageView(urlString: post.avatar)
          .clipShape(Circle())
          .frame(width: 40, height: 40)
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.gray, lineWidth: 1)
          )
        VStack(alignment: .leading){
          Text(post.username)
            .font(.title3)
            .fontWeight(.bold)
          TimeAgoStamp(date: post.date)
            .font(.caption2)
        }
        Spacer()
        AskMenu()
      }
      .padding(
        EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15)
      )
    }
}
