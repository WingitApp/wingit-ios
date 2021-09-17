//
//  DropDownMenuViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/23/21.
//

import FirebaseAuth
import SwiftUI

class AskMenuViewModel: ObservableObject {
  @Published var isReportModalOpen = false
  
  func onTapOpenReportScreen() {
    self.isReportModalOpen.toggle()

  }
  
  
}
