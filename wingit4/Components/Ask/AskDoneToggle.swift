//
//  DoneToggle.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI

struct AskDoneToggle: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @ObservedObject var askDoneToggleViewModel = AskDoneToggleViewModel()

    var body: some View {
      
      if askCardViewModel.isOwnPost {
        Button(
          action: askDoneToggleViewModel.onTapMarkAsDone,
          label: {
            Image(systemName: "checkmark.circle")
          }
        )
      }
    }
}

