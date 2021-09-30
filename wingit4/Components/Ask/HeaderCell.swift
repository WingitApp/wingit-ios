//
//  HeaderCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct HeaderCell: View {
  
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Binding var post: Post?
  var index: Int?
  
  var body: some View {
      VStack {
          HStack {
            AskCardTag(post: post)
            Spacer()
            if askCardViewModel.isProfileView {
              AskDoneToggle(post: $post) // rename later
            }
              AskMenu()
 
          }
          .padding(
            EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)
          )
      }
  }
}
