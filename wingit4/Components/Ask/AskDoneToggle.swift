//
//  DoneToggle.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI

struct AskDoneToggle: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Binding var post: Post
  var showLabel: Bool = false
  
    var body: some View {
      
        Button(
          action: {
            Haptic.impact(type: "medium")
            askCardViewModel.openCloseToggle(post: post) { newStatus in
                post.status = newStatus
            }
          },
          label: {
            if showLabel {
              HStack(alignment: .center){
                Image(systemName: "checkmark")
                  .foregroundColor(self.post.status == .closed ? .white : .black.opacity(0.7))
                  .font(.caption2)
                Text(self.post.status == .closed ? "Completed" : "Mark Complete")
                  .font(.caption2)
                  .padding(.leading, -5)
                  .foregroundColor(self.post.status == .closed ? .white : .black.opacity(0.7))
              }
              .padding(
                EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
              )
              .background(self.post.status == .closed ? Color("Color1") : .white)
              .cornerRadius(3)
              .overlay(
                RoundedRectangle(cornerRadius: 3)
                  .stroke(self.post.status == .closed ? Color("Color1") : .gray, lineWidth: 1)
              )
            } else {
              Image(systemName: "checkmark.circle")
                .foregroundColor(self.post.status == .closed ? Color("Color1") : .gray)
            }
          
          }
        )
        .disabled(!askCardViewModel.isOwnPost)
        .allowsHitTesting(askCardViewModel.isOwnPost)
        
    }
}

