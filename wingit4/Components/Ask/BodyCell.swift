//
//  BodyCell.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI


struct BodyCell: View {
  @Binding var post: Post?
  @EnvironmentObject var askCardViewModel: AskCardViewModel
    
  
    var body: some View {
      HStack{
          VStack(alignment: .leading, spacing: 10){
            Text(post?.caption ?? "")
              .fontWeight(.medium)
              .modifier(BodyStyle())
            if post?.mediaUrl != "" {
                Button(action: {
                    withAnimation(.easeInOut){
                      askCardViewModel.isImageModalOpen.toggle()
                    }
                }, label: {
                  URLImageView(urlString: post?.mediaUrl)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 250)
                    .cornerRadius(8)
                    .overlay(
                      RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.3)
                    )
                })
                .padding(.top, 10)
                .padding(.bottom, 10)
            }

          }
          .padding(.top, 5)
          .padding(.horizontal)
          .padding(.bottom, 2)
        
          Spacer(minLength: 0)
      }
      .padding(.top, 10)
      .padding(.bottom, 10)
    }
}
