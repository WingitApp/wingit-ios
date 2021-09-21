//
//  AskDetailHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import URLImage


struct AskDetailHeader: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @Binding var post: Post
  
    var body: some View {
      HStack {
        Button(action: {
          // custom back button
          self.presentationMode.wrappedValue.dismiss()
        }) {
          HStack(alignment: .center) {
            Image(systemName: "chevron.left.circle.fill")
            Text("Back")
              .font(.callout)
          }
          .foregroundColor(.wingitBlue)
   
        }
        
        

        Spacer()
        CommentButton(
          isTapDisabled: true
        )
        ReferButton(
          post: $post
        )
        AskDoneToggle(
          post: $post
        ) // rename later
        AskMenu(
          isHorizontal: true
        )
      }
      .padding(
        EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      )
    }
}
