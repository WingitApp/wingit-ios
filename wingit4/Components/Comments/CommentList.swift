//
//  CommentList.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct CommentList: View {
  @EnvironmentObject var commentViewModel : CommentViewModel
  var post: Post
  
    var body: some View {
      ScrollView {
          if !commentViewModel.comments.isEmpty {
            VStack(alignment: .leading){
              ForEach(commentViewModel.comments) { comment in
                if comment.type == .invitedReferral {
                  ReferralComment(comment: comment)
                } else {
                  UserComment(comment: comment)
                }
             }
            }
          }
      }
    }
}
