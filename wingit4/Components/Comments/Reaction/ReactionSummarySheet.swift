//
//  ReactionSummary.swift
//  wingit4
//
//  Created by Joshua Lee on 10/13/21.
//

import SwiftUI

struct ReactionSummarySheet: View {
  @EnvironmentObject var reactionSheetViewModel: ReactionSheetViewModel

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        ForEach(reactionSheetViewModel.reactors, id: \.self) { reactor in
          ReactionUserCard(reactor: reactor)
        }
        .transition(.enterAndFade)
      }
      .frame(width: UIScreen.main.bounds.width)
    }
  }
}

