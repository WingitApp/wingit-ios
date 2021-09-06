//
//  ReferralViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 9/2/21.
//

import SwiftUI
import UIKit
import FirebaseAuth
import Amplitude
import SPAlert

class ReferralsViewModel: ObservableObject {
  
  @Published var referrals: [Referral] = []

    func bumpReferral(referralId: String?) {
        guard let referralId = referralId else { return }
        Api.Referrals.updateStatus(referralId: referralId, newStatus: .bumped)
        // id of person who bumped --> current user
        // id of the new receiver
        
/*
         1. Change status to bumped for the previous referral document.
         2. Toggle new screen for the connections list for new referral
         3. Create new referral document with the new receiver & ask Ids.
         */

     
//            .where("ask")
//            .setData([ "status": true ], merge: true)
    }
    
    //after accept status is changed, add them into comments.
    
    func acceptReferral(referralId: String?) {
        guard let referralId = referralId else { return }
        Api.Referrals.updateStatus(referralId: referralId, newStatus: .accepted)
    }
    
    //when Referral ignored, status changed.
    func ignoreReferral(referralId: String?) {
            guard let referralId = referralId else { return }
            Api.Referrals.updateStatus(referralId: referralId, newStatus: .closed)
    }

}

