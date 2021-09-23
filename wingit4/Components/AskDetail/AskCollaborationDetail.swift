//
//  c.swift
//  wingit4
//
//  Created by Joshua Lee on 9/22/21.
//

import SwiftUI

struct AskCollaborationDetail: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @EnvironmentObject var commentViewModel : CommentViewModel

  @State private var showDetail: Bool = false
  
  
    var body: some View {
      if !Array(Set(askCardViewModel.bumpers + askCardViewModel.wingers)).isEmpty {

        VStack {
          VStack(alignment: .leading) {
            HStack {
                Text("Collaborators")
                  .font(.system(size:14))
                  .fontWeight(.semibold)
                Spacer()
                if !askCardViewModel.wingers.isEmpty {
                  Button( action: { withAnimation { self.showDetail.toggle() } }) {
                      Text(
                        Image(systemName: "chevron.right")
                      )
                        .font(.system(size: 15))
                        .foregroundColor(showDetail ? .wingitBlue : .gray)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.1 : 1)
                  }
                }
              }
            HStack {
              BumperCountSummary(
                users: Array(Set(askCardViewModel.bumpers + askCardViewModel.wingers)).sorted(by: {
                  $0.firstName! < $1.firstName!
                })
              )
              Spacer()
            }
            .padding(.bottom, 15)

          }
          
          if showDetail {
            if !commentViewModel.inviteHistory.isEmpty {
              VStack(alignment: .leading, spacing: 0) {
                ForEach(commentViewModel.inviteHistory) { comment in
                    ReferralComment(comment: comment)
                }
              }
              .padding(.bottom, 10)
              .background(Color.white)
            }
          }
        }
    }

     
      
      

    }
}
