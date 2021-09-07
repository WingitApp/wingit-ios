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

