//
//  TinderScreen.swift
//  wingit4
//
//  Created by Amy Chun on 10/8/21.
//

import SwiftUI

struct TinderScreen: View {
  @EnvironmentObject var referralsViewModel: ReferralsViewModel
    var body: some View {
      VStack{
      //Text("You have 10 wings")
        ZStack{
          ForEach(
            Array(
            (referralsViewModel.pendingReferrals).sorted(by: {
              $0.updatedAt?.dateValue() ?? Date()  > $1.updatedAt?.dateValue() ?? Date()
            }).enumerated()
          ),
            id: \.element
          ) { index, referral in
            if referral.status == .pending {
              TinderCard(referral: referral, post: referral.ask!).padding(8)
           }
          }
        }.zIndex(1.0)
        
        
        //Bottom
//        HStack{
//
//        }
      }
    }
}


//struct TinderScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        TinderScreen()
//    }
//}

