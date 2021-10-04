//
//  ProfileUserLinks.swift
//  wingit4
//
//  Created by Joshua Lee on 10/1/21.
//

import SwiftUI

struct ProfileUserLinks: View {
  var isOwnProfile: Bool
  
  // todo: if nill, then set opacity
    var body: some View {
      VStack(alignment: .leading, spacing: 0){
        ScrollView(.horizontal){
          HStack(alignment: .center, spacing: 20){
            SocialLink(
              name: "fb",
              bgColor: Color.fbBlueBackground,
              isEditable: isOwnProfile
            )
            SocialLink(
              name: "twitter",
              bgColor: Color.twitterBlueBackground,
              isEditable: isOwnProfile
            )
            SocialLink(
              name: "linkedin",
              bgColor: Color.backgroundBlueGray,
              isEditable: isOwnProfile
            )
            SocialLink(
              name: "instagram",
              bgColor: Color.igPurpleBackground,
              isEditable: isOwnProfile
            )
        
            SocialLink(
              name: "reddit",
              bgColor: Color.redditRedBackground,
              isEditable: isOwnProfile
            )
          
            SocialLink(
              name: "spotify",
              bgColor: Color.spotifyGreenBackground,
              isEditable: isOwnProfile
            )
            
          }
          .padding(.top, 3)

        }

        
      }
      
      .padding(.top, 20)
    }
}
