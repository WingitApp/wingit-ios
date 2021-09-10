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
        Text(post.caption)
//          .modifier(BodyStyle())
          .font(.callout)
        
        if !post.mediaUrl.isEmpty {
          HStack {
            Spacer()
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
                
                .frame(width: UIScreen.main.bounds.width - 60, height: 250)
                .cornerRadius(8)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 0.3)
                )
            })
            Spacer()
          }
          .padding(.top, 10)
            
        }
      
      }
      .padding(15)
    }
}
