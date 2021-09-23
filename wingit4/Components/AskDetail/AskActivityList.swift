//
//  AskActivityList.swift
//  wingit4
//
//  Created by Joshua Lee on 9/22/21.
//

import SwiftUI

struct AskActivityList: View {
  @EnvironmentObject var commentViewModel : CommentViewModel
  
    var body: some View {
        if !commentViewModel.inviteHistory.isEmpty {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(commentViewModel.inviteHistory) { comment in
                ReferralComment(comment: comment)
            }
          }
          .background(Color.white)
        }
    }
}

