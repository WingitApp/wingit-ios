//
//  ReferCard.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI

struct ReferCard: View {
  
  @State var referral: Referral
  @State var post: Post
  @StateObject var referViewModel = ReferViewModel()
    
  // refferal object
  /**
    user object for sender
      - mediaurl
    post object
   */
  
    var body: some View {
       
        VStack{
            ReferHeader(referral: $referral, post: $post)
            ReferBody(referral: $referral, post: $post)
            ReferFooter(referral: $referral, post: $post)
            Divider().padding(.top, 5)
        }
        .environmentObject(referViewModel)
        .sheet(
          isPresented: $referViewModel.isReferListOpen,
          content: {
            BumpConnectionsList(referral: $referral)
              .environmentObject(referViewModel)
          })
        
    }
}

