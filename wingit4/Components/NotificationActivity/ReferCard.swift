//
//  ReferCard.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI

struct ReferCard: View {
  
  @State var referral: Referral
  @StateObject var referViewModel = ReferViewModel()
    
  // refferal object
  /**
    user object for sender
      - mediaurl
    post object
   */
  
    var body: some View {
        VStack{
            ReferHeader(referral: $referral)
            ReferBody(referral: $referral)
            ReferFooter(referral: $referral)
        }
        .environmentObject(referViewModel)
        .sheet(
          isPresented: $referViewModel.isReferListOpen,
          content: {
            bumpConnectionsList(referral: $referral)
              .environmentObject(referViewModel)
          })
        
    }
}

