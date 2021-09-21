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
        NavigationView {
            ScrollView {
            if referralsViewModel.pendingReferrals.count == 0 && referralsViewModel.acceptedReferrals.count == 0 && referralsViewModel.wingedReferrals.count == 0 && referralsViewModel.closedReferrals.count == 0 {
                VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .padding(.top, 350)
                Text("No Referrals yet!")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 25)
                }
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
                    destination: self.referralsViewModel.destination,
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
  
    var body: some View {
        
            ScrollView {
            if referralsViewModel.pendingReferrals.count == 0 && referralsViewModel.acceptedReferrals.count == 0 && referralsViewModel.wingedReferrals.count == 0 && referralsViewModel.closedReferrals.count == 0 {
                VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .padding(.top, 350)
                Text("No Referrals yet!")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 25)
                }
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
                    destination: self.referralsViewModel.destination,
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
