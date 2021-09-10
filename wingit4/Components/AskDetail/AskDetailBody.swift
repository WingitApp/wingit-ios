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
    @EnvironmentObject var askCardViewModel: AskCardViewModel

    var body: some View {
      VStack(alignment: .center) {
        HStack{
            Text(post.caption)
              .font(.callout)
            Spacer()
        }
       
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
