//
//  ReactionSheetViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 10/13/21.
//

import SwiftUI
import BottomSheet

class ReactionSheetViewModel: ObservableObject {
  // reaction summary TODO: move to own viewmodel
  @Published var bottomSheetPosition: BottomSheetPosition = .hidden
  @Published var reactions: [Reaction] = []
  @Published var activeIndex: Int = 0
  @Published var reactors: [UserPreview] = []
  
  
    
  func openReactionSummarySheet(
    reactions: [Reaction] = []
  ) {
    self.reactions = reactions
    self.activeIndex = 0
    let reaction = reactions[activeIndex]
    self.reactors =  Array(reaction.reactors.values)
    self.bottomSheetPosition = .middle
  }
  
  func closeReactionSummarySheet(onClose: @escaping () -> Void) {
    self.bottomSheetPosition = .hidden
    onClose()
  }
  
  func onTabSelect(_ index: Int) {
    if activeIndex == index { return }
    let reaction = reactions[index]
    activeIndex = index
    reactors =  Array(reaction.reactors.values)
  }
}
  
