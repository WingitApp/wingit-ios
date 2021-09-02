//
//  CommentList.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct CommentList: View {
  @EnvironmentObject var commentViewModel : CommentViewModel
  @Binding var post: Post
  
    var body: some View {
      ScrollView {
        VStack(alignment: .leading) {
          if !commentViewModel.comments.isEmpty {
              ForEach(commentViewModel.comments) { comment in
                UserComment(comment: comment)
             }
          }
//          Spacer()
        }
      }
    }
}
