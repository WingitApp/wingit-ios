//
//  DoneToggle.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI

struct AskDoneToggle: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
 
    var body: some View {
      
      if askCardViewModel.isOwnPost {
        Button(
            action: askCardViewModel.openCloseToggle,
          label: {
            Image(systemName: "checkmark.circle")
              .foregroundColor(self.askCardViewModel.isMarkedAsDone ? Color("Color1") : Color.gray)
              }
            )
      }
    }
}

