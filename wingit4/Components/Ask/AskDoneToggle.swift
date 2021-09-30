//
//  DoneToggle.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI
import FirebaseAuth
import SPAlert

struct AskDoneToggle: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Binding var post: Post?
  var showLabel: Bool = false
  
    var body: some View {
      
        Button(
          action: {
            Haptic.impact(type: "hard")
            askCardViewModel.openCloseToggle(post: post) { newStatus in
              post?.status = newStatus
//              let alertView = SPAlertView( title: "", preset: SPAlertIconPreset.done)
//              alertView.present(duration: 1)
            }
          },
          label: {
            if showLabel && Auth.auth().currentUser?.uid != post?.ownerId {
              HStack(alignment: .center){
                Image(systemName: self.post?.status == .closed ? "checkmark" : "")
                  .foregroundColor(self.post?.status == .closed ? .white : .black.opacity(0.7))
                  .font(.caption2)
                Text(self.post?.status == .closed ? "Completed" : "Incomplete")
                  .font(.caption2)
                  .fontWeight(.semibold)
                  .padding(.leading, -5)
                  .foregroundColor(self.post?.status == .closed ? .white : .black.opacity(0.7))
              }
              .padding(
                EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
              )
              .background(self.post?.status == .closed ? Color.statusGreen : .white)
              .cornerRadius(3)
              .overlay(
                RoundedRectangle(cornerRadius: 3)
                  .stroke(self.post?.status == .closed ? Color.statusGreen : .gray, lineWidth: 1)
              )
            } else if showLabel && Auth.auth().currentUser?.uid == post?.ownerId {
                HStack(alignment: .center){
                  Image(systemName: "checkmark")
                    .foregroundColor(self.post?.status == .closed ? .white : .black.opacity(0.7))
                    .font(.caption2)
                  Text(self.post?.status == .closed ? "Completed" : "Mark Complete")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.leading, -5)
                    .foregroundColor(self.post?.status == .closed ? .white : .black.opacity(0.7))
                }
                .padding(
                  EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
                )
                .background(self.post?.status == .closed ? Color.statusGreen : .white)
                .cornerRadius(3)
                .overlay(
                  RoundedRectangle(cornerRadius: 3)
                    .stroke(self.post?.status == .closed ? Color.statusGreen : .gray, lineWidth: 1)
                )
              } else {
              Image(systemName: "checkmark.circle")
                .foregroundColor(self.post?.status == .closed ? Color.statusGreen : .gray)
            }
          
          }
        )
        .disabled(!askCardViewModel.isOwnPost)
        .allowsHitTesting(askCardViewModel.isOwnPost)
        
    }
}

