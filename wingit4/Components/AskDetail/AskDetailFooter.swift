//
//  AskDetailFooter.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailFooter: View {
  @Binding var post: Post
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @EnvironmentObject var footerCellViewModel: FooterCellViewModel
  @EnvironmentObject var shareButtonViewModel: ShareButtonViewModel


    var body: some View {
      Divider()
      HStack {
        Image(systemName: "heart.circle.fill")
          .foregroundColor(.red)
          .font(.system(size: 25))
                Image(systemName: "message")
          .foregroundColor(Color(.systemTeal))
          .padding(.leading, 5)
          .font(.system(size: 20))
        Spacer()
        Image(systemName: "arrowshape.turn.up.right")
          .foregroundColor(Color(.systemTeal))

      }
      .padding(.leading, 15)
      .padding(.trailing, 15)
      Divider()
    }
}
