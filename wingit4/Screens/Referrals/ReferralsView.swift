//
//  ReferralView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/2/21.
//

import SwiftUI

struct ReferralsView: View {
  @StateObject var referralsViewModel = ReferralsViewModel()
  
    var body: some View {
      ScrollView {
        VStack(alignment: .leading) {
          ForEach(self.referralsViewModel.referrals, id: \.id) { referral in
            ReferCard(referral: referral)
          }
        }
      }
      .environmentObject(referralsViewModel)
      
      .onAppear {
        Api.Referrals.getPendingReferrals() { referrals in
            referralsViewModel.referrals = referrals
        }
      }
    }
}
