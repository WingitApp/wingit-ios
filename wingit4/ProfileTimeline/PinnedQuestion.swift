//
//  PinnedQuestion.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct PinnedQuestion: View {
  
  var question: String = "Question"
  
    var body: some View {
        Text(question)
        .frame(width: 350, height: 100)
        .cornerRadius(10)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray, lineWidth: 0.3)
        )
        .padding()
    }
}

struct PinnedQuestion_Previews: PreviewProvider {
    static var previews: some View {
        PinnedQuestion()
    }
}
