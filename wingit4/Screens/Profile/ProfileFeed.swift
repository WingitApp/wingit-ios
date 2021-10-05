//
//  ProfileFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 9/13/21.
//

import SwiftUI

struct ProfileFeed: View {

    var isOwnProfile: Bool
  /**these function are needed to keep posts sorted b/c
   posts are closed/opened at random sequences by user*/
    

    var body: some View {
      if isOwnProfile {
        OwnProfileFeed()
      } else {
        UserProfileFeed()
      }
   }
}

