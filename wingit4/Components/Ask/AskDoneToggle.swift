//
//  DoneToggle.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI

struct AskDoneToggle: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
 // @ObservedObject var askDoneToggleViewModel = AskDoneToggleViewModel()
   // @Binding var post: Post

    var body: some View {
      
      if askCardViewModel.isOwnPost {
        Button(
            action: askCardViewModel.statusClosed,
          label: {
            Image(systemName: "checkmark.circle")
              }
            )
      }
    }
}

