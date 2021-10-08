//
//  ProfileFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 9/13/21.
//

import SwiftUI

struct ProfileFeed: View {

    var isOwnProfile: Bool

    var body: some View {
      if isOwnProfile {
        OwnProfileFeed()
      } else {
        UserProfileFeed()
      }
   }
}

