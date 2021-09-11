//
//  DropDownMenuViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/23/21.
//

import FirebaseAuth
import SwiftUI

class AskMenuViewModel: ObservableObject {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Published var isReportModalOpen = false
  
  func onTapOpenReportScreen() {
    self.isReportModalOpen.toggle()

  }
  
  
}
