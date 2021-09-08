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
        if !referralsViewModel.referrals.isEmpty {
            VStack(alignment: .leading){
              ForEach(self.referralsViewModel.referrals, id: \.id) { referral in
                HStack {
                    if referral.status.rawValue == "accepted" {
                        ZStack{
                            AcceptedNotification(referral: referral)
                          //  Text("You have bumped their request")
                        }
                    } else if referral.status.rawValue == "bumped" {
                        ZStack{
                           BumpedNotification(referral: referral)
                        }
                    }
                    else {
                        ReferCard(referral: referral, post: referral.ask!)
                    }
                }
              }
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
