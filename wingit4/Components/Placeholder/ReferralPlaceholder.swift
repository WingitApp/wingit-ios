//
//  ReferralPlaceholder.swift
//  wingit4
//
//  Created by Joshua Lee on 9/25/21.
//

import SwiftUI

struct ReferralPlaceholder: View {
  var type: String = "pending"
  
    var body: some View {
      if type == "pending" {
        ReferCard(
          referral: Placeholders.referral,
          post: Placeholders.post
        )
        .allowsHitTesting(false)
        .redacted(reason: .placeholder)
        .padding(.bottom, 15)
      } else {
        AcceptCard(
          referral: Placeholders.referral,
          post: Placeholders.post
        )
        .allowsHitTesting(false)
        .redacted(reason: .placeholder)
        .padding(.bottom, 15)
      }
  }
}
