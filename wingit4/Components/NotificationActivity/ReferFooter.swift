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
            
            BumpButton(referral: $referral)
            AcceptButton(referral: $referral, post: $post)
            
        }
    }
}

struct AcceptButton: View {
    
    @EnvironmentObject var referralsViewModel: ReferralsViewModel
    @Binding var referral: Referral
    @Binding var post: Post
   
    
    var body: some View {
        //one pressed, status is changed.
        //deleted from refer page.
        //enters into the postId or referralId post detail comment view
        //in current user's notification, also having a navigation view to the comment view. You have accepted. (navigation) or in the referral.
        Button(action: {
            referralsViewModel.acceptReferral(referral: referral, onSuccess: {})
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
                .background(
                            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(15)
        })

    }
}

struct BumpButton: View {
    @EnvironmentObject var referViewModel: ReferViewModel


    @Binding var referral: Referral
    
    var body: some View {
        
        Button(action: {referViewModel.isReferListOpen.toggle()},
               label: {
                VStack{
                    Text("Bump")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
                .background(
                            LinearGradient(gradient: .init(colors: [Color("Color1"),Color("Color")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(15)
        })
        

    }
}
