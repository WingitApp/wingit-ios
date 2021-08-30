//
//  BodyCell.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI
import URLImage

struct BodyCell: View {
  @Binding var post: Post
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  
    var body: some View {
      HStack{
          VStack(alignment: .leading, spacing: 10){
            Text(post.caption).modifier(BodyStyle())
            if post != nil && post.mediaUrl != "" {
                Button(action: {
                    withAnimation(.easeInOut){
                      askCardViewModel.isImageModalOpen.toggle()
                    }
                }, label: {
                  URLImage(URL(string: post.mediaUrl)!,
                    content: {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }).frame(width: UIScreen.main.bounds.width - 60, height: 250)
                      .cornerRadius(15)
                })
            }
          }.padding(.horizontal).padding(.bottom, 2)
          Spacer(minLength: 0)
      }
      .padding(.top, 10)
      .padding(.bottom, 10)
    }
}
