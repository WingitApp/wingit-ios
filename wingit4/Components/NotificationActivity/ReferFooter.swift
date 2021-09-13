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
       
        NavigationLink(
            destination: AskDetailView(post: $post)
                .environmentObject(askCardViewModel)
                .environmentObject(askMenuViewModel)
                .environmentObject(askDoneToggleViewModel)
                .environmentObject(commentViewModel)
                .environmentObject(commentInputViewModel)
                .environmentObject(footerCellViewModel),
            isActive: $userHasAccepted,
            label: {
                Button(action: {
                    referralsViewModel.acceptReferral(referral: referral, onSuccess: {self.userHasAccepted.toggle()})
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
                        .frame(width: (UIScreen.main.bounds.width / 2 ) - 40)
                        .background(Color(.systemTeal))
                        .cornerRadius(5)
                        .overlay(
                          RoundedRectangle(cornerRadius: 5).stroke(Color(.lightGray),
                          lineWidth: 1)
                        )
                })
            })
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
                  .frame(width: 25, height: 20)
                  
                    Text("Wing")
                      .foregroundColor(Color("Color"))
                      .fontWeight(.bold)
                }
                
                .padding(.vertical, 10)
                .frame(width: (UIScreen.main.bounds.width / 2 ) - 40)
                .background(Color.white)
                .cornerRadius(5)
                .overlay(
                  RoundedRectangle(cornerRadius: 5).stroke(Color("Color"),
                  lineWidth: 1)
                )
        })
        

    }
}
