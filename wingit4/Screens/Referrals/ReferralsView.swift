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
        if !referralsViewModel.referrals.isEmpty {
            VStack(alignment: .leading){
              ForEach(self.referralsViewModel.referrals, id: \.id) { referral in
                HStack {
                    if referral.status.rawValue == "accepted" {
                        ZStack{
//                            NavigationLink(destination: AskDetailView(post.postId: referral.askId)) {
//                                                                  EmptyView()
//                                                              }
                            AcceptedNotification(referral: referral)
                        }
                    } else if referral.status.rawValue == "bumped" {
                        ZStack{
                           BumpedNotification(referral: referral)
                        }
                    }
                    else if referral.status.rawValue == "closed" {
                        ZStack{
                            ClosedNotification(referral: referral)
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
      .navigationBarTitle("Referrals", displayMode: .inline)
    }
      
    }
}
