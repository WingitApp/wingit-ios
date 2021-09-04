//
//  ReferralView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/2/21.
//

import SwiftUI

struct ReferralView: View {
  @StateObject var referralViewModel = ReferralViewModel()
  
    var body: some View {
      ScrollView {
        VStack(alignment: .leading) {
          ForEach(self.referralViewModel.referrals, id: \.id) { referral in
            ReferCard(referral: referral)
          }
        }
      }
      .onAppear {
        Api.Referrals.getReferralsWithJoins() { referrals in
          print("referrals", referrals)
        }
      }
    }
}
