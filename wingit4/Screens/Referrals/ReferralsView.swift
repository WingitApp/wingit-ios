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
    @ObservedObject var contactsListViewModel = ContactsListViewModel()


    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
              if referralsViewModel.isLoading {
                ReferralPlaceholder(type: "accepted")
                ReferralPlaceholder(type: "accepted")
                ReferralPlaceholder(type: "accepted")
              } else if (
              !referralsViewModel.isLoading &&
              referralsViewModel.pendingReferrals.isEmpty &&
              referralsViewModel.acceptedReferrals.isEmpty &&
              referralsViewModel.wingedReferrals.isEmpty &&
              referralsViewModel.closedReferrals.isEmpty
             ) {
                PostEmptyState(
                  title: "No Referrals!",
                  description: "Tell your friends to wing asks to you.",
                  iconName: "paperplane",
                  iconColor: Color("Color"),
                  function: nil
                ).padding(.top, 285)
              } else {
              // TODO: fix this implementation (this is quick fix)
                ReferralFeed()
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
                  if  referralsViewModel.pendingListener == nil {
                    self.referralsViewModel.getReferrals()
                  }
                }
                .navigationBarTitle("Referrals Inbox", displayMode: .inline)
            }
 
      }
}
