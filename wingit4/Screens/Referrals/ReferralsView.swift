//
//  ReferralView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/2/21.
//

import SwiftUI

struct ReferralsView: View {
    @StateObject var referralsViewModel = ReferralsViewModel()
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()
    // Like
    @StateObject var footerCellViewModel = FooterCellViewModel()
  
    var body: some View {
        NavigationView {
            ScrollView {
             if (
              !referralsViewModel.isLoading &&
              referralsViewModel.pendingReferrals.count == 0 &&
              referralsViewModel.acceptedReferrals.count == 0 &&
              referralsViewModel.wingedReferrals.count == 0 &&
              referralsViewModel.closedReferrals.count == 0
             ) {
                EmptyState(
                  title: "No Referrals!",
                  description: "Tell your friends to wing asks to you.",
                  iconName: "paperplane",
                  iconColor: Color("Color"),
                  function: nil
                ).padding(.top, 285)
            } else {
                  LazyVStack(alignment: .leading) {
      //                if !referralsViewModel.pendingReferrals.isEmpty {
      //                    Text("Pending")
      //                }
                      ForEach(Array(self.referralsViewModel.pendingReferrals.enumerated()), id: \.element) { index, referral in
                          ReferCard(referral: referral, post: referral.ask!)
                      }
                    
      //                if !referralsViewModel.acceptedReferrals.isEmpty {
      //                    Text("Accepted")
      //                }
                      ForEach(Array(self.referralsViewModel.acceptedReferrals.enumerated()), id: \.element) { index, referral in
                          if (referral.ask != nil) {
                              AcceptCard(referral: referral, post: referral.ask!)
                          }
                      }
      //                if !referralsViewModel.wingedReferrals.isEmpty {
      //                    Text("Winged")
      //                }
                      ForEach(Array(self.referralsViewModel.wingedReferrals.enumerated()), id: \.element) { index, referral in
                          WingCard(referral: referral, post: referral.ask!)
                      }
      //                if !referralsViewModel.closedReferrals.isEmpty {
      //                    Text("Closed")
      //                }
                      ForEach(Array(self.referralsViewModel.closedReferrals.enumerated()), id: \.element) { index, referral in
                          ClosedCard(referral: referral, post: referral.ask!)
                      }
                    }
                 }
                NavigationLink(
                    destination:
                        self.referralsViewModel.destination
                        .environmentObject(askCardViewModel)
                        .environmentObject(askMenuViewModel)
                        .environmentObject(askDoneToggleViewModel)
                        .environmentObject(commentViewModel)
                        .environmentObject(commentInputViewModel)
                        .environmentObject(footerCellViewModel),
                    isActive: self.$referralsViewModel.isLinkActive
                ) {
                    EmptyView()
                }
             }
                .padding(.top, 5)
                .background(
                  Color.white.ignoresSafeArea(.all, edges: .all)
                )
                .environmentObject(referralsViewModel)
                .onAppear {
                  self.referralsViewModel.getReferrals()
                }
                .navigationBarTitle("Referrals", displayMode: .inline)
            }
 
      }
}

struct ReferralsNotificationView: View {
    @StateObject var referralsViewModel = ReferralsViewModel()
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()
    // Like
    @StateObject var footerCellViewModel = FooterCellViewModel()
  
    var body: some View {

            ScrollView {
            if referralsViewModel.pendingReferrals.count == 0 && referralsViewModel.acceptedReferrals.count == 0 && referralsViewModel.wingedReferrals.count == 0 && referralsViewModel.closedReferrals.count == 0 {
                EmptyState(
                  title: "No Referrals!",
                  description: "Tell your friends to wing asks to you.",
                  iconName: "airplane",
                  iconColor: Color("Color"),
                  function: nil
                ).padding(.top, 285)
            } else {
                  LazyVStack(alignment: .leading) {
      //                if !referralsViewModel.pendingReferrals.isEmpty {
      //                    Text("Pending")
      //                }
                      ForEach(Array(self.referralsViewModel.pendingReferrals.enumerated()), id: \.element) { index, referral in
                          ReferCard(referral: referral, post: referral.ask!)
                      }
                    
      //                if !referralsViewModel.acceptedReferrals.isEmpty {
      //                    Text("Accepted")
      //                }
                      ForEach(Array(self.referralsViewModel.acceptedReferrals.enumerated()), id: \.element) { index, referral in
                          if (referral.ask != nil) {
                              AcceptCard(referral: referral, post: referral.ask!)
                          }
                      }
      //                if !referralsViewModel.wingedReferrals.isEmpty {
      //                    Text("Winged")
      //                }
                      ForEach(Array(self.referralsViewModel.wingedReferrals.enumerated()), id: \.element) { index, referral in
                          WingCard(referral: referral, post: referral.ask!)
                      }
      //                if !referralsViewModel.closedReferrals.isEmpty {
      //                    Text("Closed")
      //                }
                      ForEach(Array(self.referralsViewModel.closedReferrals.enumerated()), id: \.element) { index, referral in
                          ClosedCard(referral: referral, post: referral.ask!)
                      }
                    }
                 }
                NavigationLink(
                    destination:
                        self.referralsViewModel.destination
                        .environmentObject(askCardViewModel)
                        .environmentObject(askMenuViewModel)
                        .environmentObject(askDoneToggleViewModel)
                        .environmentObject(commentViewModel)
                        .environmentObject(commentInputViewModel)
                        .environmentObject(footerCellViewModel),
                    isActive: self.$referralsViewModel.isLinkActive
                ) {
                    EmptyView()
                }
             }
                .padding(.top, 5)
                .background(
                  Color.white.ignoresSafeArea(.all, edges: .all)
                )
                .environmentObject(referralsViewModel)
                .onAppear {
                  self.referralsViewModel.getReferrals()
                }
                .navigationBarTitle("Referrals", displayMode: .inline)
      }
}
