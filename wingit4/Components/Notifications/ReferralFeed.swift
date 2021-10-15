//
//  ReferralFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 9/22/21.
//

import SwiftUI

struct ReferralFeed: View {
  @EnvironmentObject var referralsViewModel: ReferralsViewModel

  var body: some View {
    // todo: refactor to better way
    LazyVStack(alignment: .leading) {
      ForEach(
        Array(
          (referralsViewModel.pendingReferrals + referralsViewModel.acceptedReferrals +
            referralsViewModel.wingedReferrals + referralsViewModel.closedReferrals
          ).sorted(by: {
            $0.updatedAt?.dateValue() ?? Date()  > $1.updatedAt?.dateValue() ?? Date()
          }).enumerated()
        ),
        id: \.element
      ) { index, referral in
        if referral.status == .accepted {
          AcceptCard(referral: referral, post: referral.ask)
        } else if referral.status == .closed {
          ClosedCard(referral: referral, post: referral.ask)
        } else if referral.status == .pending {
          ReferCard(referral: referral, post: referral.ask)
        } else if referral.status == .winged {
          WingCard(referral: referral, post: referral.ask)
        }
        
      }
      
    }
  }
}
