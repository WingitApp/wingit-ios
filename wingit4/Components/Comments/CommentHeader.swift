//
//  UserCommentHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 10/13/21.
//

import SwiftUI

struct CommentHeader: View {
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel

  var comment: Comment
  var isTopComment: Bool
  var onTap: (() -> Void)? = nil
  
  func onTapAction() -> Void {
    guard let onTap = self.onTap else {return}
    onTap()
  }
  
  var body: some View {
    HStack(alignment: .center) {
      Text(comment.username ?? "")
        .font(.system(size:13))
        .fontWeight(.semibold)
      if isTopComment {
        HStack(spacing: 3){
          Text(Image(systemName: "star.circle.fill"))
          Text("Best Answer")
        }
        .foregroundColor(Color.uiorange)
        .font(.system(size: 10))
        .allowsHitTesting(false)
      }
      Circle()
        .modifier(CircleDotStyle())
      Text(
        timeAgoSinceDate(
          Date(timeIntervalSince1970: comment.date ?? 0),
          currentDate: Date(),
          numericDates: true
        )
      )
        .foregroundColor(.gray)
        .font(.system(size: 10))
      Spacer()
      EditTag(comment: comment)
    }
    .onTapGesture(perform: onTapAction)
    .environmentObject(commentSheetViewModel)
  }
}
