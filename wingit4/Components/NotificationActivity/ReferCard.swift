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
  @EnvironmentObject var referViewModel: ReferViewModel
    
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
//        .modifier(CardStyle())
//        .modifier(FeedItemShadow())
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .environmentObject(referViewModel)
//        .sheet(
//          isPresented: $referViewModel.isReferListOpen,
//          content: {
//            WingConnectionsList(referral: $referral)
//              .environmentObject(referViewModel)
//          })
        
    }
}

struct WingCard: View {
  
  @State var referral: Referral
  @State var post: Post
 
    
  // refferal object
  /**
    user object for sender
      - mediaurl
    post object
   */
  
    var body: some View {
       
        VStack{
            WingNotification(referral: $referral, post: $post)
            Divider().padding(.top, 5)
        }
        
    }
}

struct AcceptCard: View {
  
  @State var referral: Referral
  @State var post: Post
 
    
  // refferal object
  /**
    user object for sender
      - mediaurl
    post object
   */
  
    var body: some View {
       
        VStack{
            AcceptedNotification(referral: $referral, post: $post)
            Divider().padding(.top, 5)
        }
        
    }
}

struct ClosedCard: View {
  
  @State var referral: Referral
  @State var post: Post
 
    
  // refferal object
  /**
    user object for sender
      - mediaurl
    post object
   */
  
    var body: some View {
       
        VStack{
            ClosedNotification(referral: $referral, post: $post)
            Divider().padding(.top, 5)
        }
        
    }
}


