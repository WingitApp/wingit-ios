//
//  DoneToggleViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI

class AskDoneToggleViewModel: ObservableObject {
  
  @Published var isMarkedAsDone: Bool = false
  
  func onTapMarkAsDone() {
    self.isMarkedAsDone.toggle()
  }
}
