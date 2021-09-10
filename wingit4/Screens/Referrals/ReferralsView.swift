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
                            AcceptCard(referral: referral, post: referral.ask!)
                        }
                    } else if referral.status.rawValue == "bumped" {
                        ZStack{
                            BumpCard(referral: referral, post: referral.ask!)
                        }
                    }
                    else if referral.status.rawValue == "closed" {
                        ZStack{
                            ClosedCard(referral: referral, post: referral.ask!)
                        }
                    }
                    else {
                        ReferCard(referral: referral, post: referral.ask!)
                    }
                }
              }
            }
        }
    
      }.padding(.top, 5)
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
