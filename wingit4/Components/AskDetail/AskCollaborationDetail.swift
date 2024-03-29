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
  @State private var collaborators: [User] = []

  @State private var showDetail: Bool = false
  
  
    var body: some View {
      if !askCardViewModel.bumpers.isEmpty && !askCardViewModel.wingers.isEmpty {

        VStack {
          VStack(alignment: .leading) {
            HStack {
                Text("Collaborators")
                  .font(.system(size:14))
                  .fontWeight(.semibold)
                Spacer()
                if !askCardViewModel.wingers.isEmpty {
                  Button( action: {
                    Haptic.impact(type: "soft")
                    withAnimation { self.showDetail.toggle() }
                  }) {
                      Text(
                        Image(systemName: "chevron.right")
                      )
                        .font(.system(size: 15))
                        .foregroundColor(showDetail ? .wingitBlue : .gray)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                      .padding(.bottom, 10)
                  }
                }
              }
            HStack {
              BumperCountSummary(
                users: Array(Set(askCardViewModel.bumpers + askCardViewModel.wingers)).sorted(by: {
                  $0.id! < $1.id!
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
              .animation(.easeInOut) // 2
              .transition(.enterLeftAndFade)
              .padding(.bottom, 10)
            }
          }
        }
    }

     
      
      

    }
}
