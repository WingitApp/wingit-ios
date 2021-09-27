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
              .padding([.horizontal])
            ReferBody(referral: $referral, post: $post)
              .padding([.vertical])
            ReferFooter(referral: $referral, post: $post)
              .padding([.horizontal])
            Divider().padding(.top, 5)
        }
//        .modifier(CardStyle())
//        .modifier(FeedItemShadow())
        .environmentObject(referViewModel)
        .sheet(
          isPresented: $referViewModel.isReferListOpen,
          content: {
            ReferConnectionsList(
              post: $post,
              referral: referral
            )
              .environmentObject(referViewModel)
          })

        
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


