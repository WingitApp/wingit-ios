//
//  ReactionSummaryHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 10/13/21.
//

import SwiftUI

struct ReactionSummaryHeader: View {
  @EnvironmentObject var reactionSheetViewModel: ReactionSheetViewModel
  @Namespace var name
  

  
  var body: some View {
    HStack(spacing: 0){
      ForEach(Array(reactionSheetViewModel.reactions.enumerated()), id: \.element) { index, reaction in
        ReactionSummaryTab(
          index: index,
          emojiCode: reaction.emojiCode,
          namespace: name,
          isActive: reactionSheetViewModel.activeIndex == index,
          onTap: reactionSheetViewModel.onTabSelect
        )
      }
    }
    .frame(width: UIScreen.main.bounds.width + 30)
    .padding(.top, 10)
    
  }
}
