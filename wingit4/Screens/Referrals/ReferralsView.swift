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
        NavigationView{
          ScrollView {
            VStack(alignment: .leading) {
                if !referralsViewModel.pendingReferrals.isEmpty {
                    Text("Pending")
                }
                ForEach(self.referralsViewModel.pendingReferrals) { referral in
                    HStack {
                        ZStack {
                            ReferCard(referral: referral, post: referral.ask!)
                        }
                    }
                }
                if !referralsViewModel.acceptedReferrals.isEmpty {
                    Text("Accepted")
                }
                ForEach(self.referralsViewModel.acceptedReferrals) { referral in
                        HStack {
                            ZStack{
                                AcceptCard(referral: referral, post: referral.ask!)
                            }
                        }
                }
                if !referralsViewModel.wingedReferrals.isEmpty {
                    Text("Winged")
                }
                ForEach(self.referralsViewModel.wingedReferrals) { referral in
                        ZStack{
                            WingCard(referral: referral, post: referral.ask!)
                        }
                }
                if !referralsViewModel.closedReferrals.isEmpty {
                    Text("Closed")
                }
                ForEach(self.referralsViewModel.closedReferrals) { referral in
                        ZStack{
                            ClosedCard(referral: referral, post: referral.ask!)
                        }
                }
              }
           }
          .padding(.top, 5)
          .environmentObject(referralsViewModel)
          .onAppear {
            self.referralsViewModel.getReferrals()
          }
          .navigationBarTitle("Referrals", displayMode: .inline)
          }
      }
}
