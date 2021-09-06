//
//  ReferFooter.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/2/21.
//

import SwiftUI

struct ReferFooter: View {
  @Binding var referral: Referral
  
    var body: some View {
        
        HStack(spacing: 20){
            
            BumpButton(referral: $referral)
            AcceptButton(referral: $referral)
            
        }
    }
}

struct AcceptButton: View {
    
    @EnvironmentObject var referralsViewModel: ReferralsViewModel
    @Binding var referral: Referral
    
    var body: some View {
        
        Button(action: {referralsViewModel.acceptReferral(referralId: referral.id)},
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

    }
}

struct BumpButton: View {
    
    @EnvironmentObject var referralsViewModel: ReferralsViewModel
    @Binding var referral: Referral
    
    var body: some View {
        
        Button(action: {referralsViewModel.bumpReferral(referralId: referral.id)},
               label: {
                VStack{
                    Text("Bump")
                        .foregroundColor(.pink)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.pink.opacity(0.5),lineWidth: 1.5))
        })

    }
}
