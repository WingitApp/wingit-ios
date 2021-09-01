//
//  ReferViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import Foundation
import SwiftUI
import Firebase

class ReferViewModel: ObservableObject {
    
    @Published var isReferSheetShown = false
 
    func toggleReferScreen() {
      self.isReferSheetShown.toggle()
    }
    
}

