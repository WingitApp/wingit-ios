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
                        .foregroundColor(.green)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.green.opacity(0.5),lineWidth: 1.5))
        })
//        NavigationLink (
//            destination: AskDetailView(post: $post),
//            label: {
//                Button(action: {
//                    referralsViewModel.acceptReferral(referral: referral, onSuccess: {})
//                },
//                       label: {
//                        VStack{
//                            Text("Accept")
//                                .foregroundColor(.green)
//                        }
//                        .padding(.vertical, 10)
//                        .padding(.horizontal, 30)
//                        .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
//                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.green.opacity(0.5),lineWidth: 1.5))
//                })
//            })
   

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
                        .foregroundColor(Color(.systemTeal))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color(.systemTeal).opacity(0.5),lineWidth: 1.5))
        })
        

    }
}
