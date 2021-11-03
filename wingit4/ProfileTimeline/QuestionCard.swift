//
//  QuestionCard.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct QuestionCard: View {
    var body: some View {
        
      VStack(spacing: 10) {
        ProfilePageHeader()
        Collaborators()
      }
      .frame(width: 350)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color.gray, lineWidth: 0.3)
      )
    }
}

struct QuestionCard_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCard()
    }
}
