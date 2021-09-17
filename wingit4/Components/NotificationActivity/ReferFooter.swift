//
//  ReferFooter.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/2/21.
//

import SwiftUI

struct ReferFooter: View {
    
  @Binding var referral: Referral
  @Binding var post: Post
  
    var body: some View {
        
        HStack(spacing: 20){
            WingButton(referral: $referral)
            AcceptButton(referral: $referral, post: $post)
        }

    }
}

struct AcceptButton: View {
    
    @EnvironmentObject var referralsViewModel: ReferralsViewModel
    @Binding var referral: Referral
    @Binding var post: Post
    @State var userHasAccepted: Bool = false
//    NavigationLink(
//     destination: AskDetailView(post: $post),
//     isActive: $userHasAccepted
//     {EmptyView()}
    
    var body: some View {
        Button(action: {
            referralsViewModel.acceptReferral(referral: referral, post: $post)
        },
               label: {
                HStack(alignment: .center) {
                  Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                  Text("Accept")
                    .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .frame(width: (UIScreen.main.bounds.width / 2 ) - 25)
                .background(Color(.systemTeal))
                .cornerRadius(5)
                .overlay(
                  RoundedRectangle(cornerRadius: 5).stroke(Color(.systemTeal),
                  lineWidth: 1)
                )
        }).disabled(self.userHasAccepted)
    }
}

struct WingButton: View {
    @EnvironmentObject var referViewModel: ReferViewModel


    @Binding var referral: Referral
    
    var body: some View {
        
        Button(action: {
            logToAmplitude(event: .tapWingReferralButton)
            referViewModel.isReferListOpen.toggle()
        },
               label: {
                HStack(alignment: .center){
                  VStack {
                    Image(IMAGE_LOGO)
                      .resizable()
                      .scaledToFit()
                  }
                  .frame(width: 30, height: 20)
                  
                    Text("Wing")
                      .foregroundColor(Color.wingitBlue)
                      .fontWeight(.bold)
                }
                
                .padding(.vertical, 10)
                .frame(width: (UIScreen.main.bounds.width / 2 ) - 25)
                .background(Color.white)
                .cornerRadius(5)
                .overlay(
                  RoundedRectangle(cornerRadius: 5).stroke(Color.wingitBlue,
                                                           lineWidth: 1.5)
                )
        })
        

    }
}
