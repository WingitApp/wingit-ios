//
//  FeedToggle.swift
//  wingit4
//
//  Created by Joshua Lee on 8/21/21.
//

import SwiftUI

struct FeedToggle: View {
  @EnvironmentObject var homeViewModel: HomeViewModel
  
  func onToggleChange(selection: Selection) -> Void {
    homeViewModel.onSelectionChange(selection: selection)
      // logs to amplitude
    if selection == .posts {
        logToAmplitude(event: .viewHomeRecsFeed)
    } else {
        logToAmplitude(event: .viewHomeAsksFeed)
    }
    
    
  }

  
  var body: some View {
    VStack {
      Picker(
        selection: $homeViewModel.selection,
        label: Text("Grid or Table")
      ) {
        ForEach(Selection.allCases) { selection in
          selection.label.tag(selection)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      .padding(.leading, 20)
      .padding(.trailing, 20)
      .onChange(of: homeViewModel.selection, perform: onToggleChange)
    }
  }
}

//  struct FeedToggleStyle: ViewModifier {
//    func body(content: Content) -> some View {
//      content
//
//    }
//  }
