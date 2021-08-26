//
//  DoneToggle.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI

struct FulfilledToggle: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @ObservedObject var doneToggleViewModel = DoneToggleViewModel()

    var body: some View {
      
      if askCardViewModel.isOwnPost {
        Button(
          action: doneToggleViewModel.onTapMarkAsDone,
          label: {
            Image(systemName: "checkmark.circle")
          }
        )
      }
    }
}

