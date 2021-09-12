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
                        VStack{
                            Text("Accept")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
                        .background(Color("Color"))
                        .cornerRadius(15)
                })
            })
    }
}

struct WingButton: View {
    @EnvironmentObject var referViewModel: ReferViewModel


    @Binding var referral: Referral
    
    var body: some View {
        
        Button(action: {referViewModel.isReferListOpen.toggle()},
               label: {
                VStack{
                    Text("Wing")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
                .background( Color("Color1"))
                .cornerRadius(15)
        })
        

    }
}
