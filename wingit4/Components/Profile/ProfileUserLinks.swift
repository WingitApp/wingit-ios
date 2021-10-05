//
//  ProfileUserLinks.swift
//  wingit4
//
//  Created by Joshua Lee on 10/1/21.
//

import SwiftUI

struct ProfileUserLinks: View {
  
  var user: User
  var isOwnProfile: Bool
  
  // todo: if nill, then set opacity
    var body: some View {
      VStack(alignment: .leading, spacing: 0){
        ScrollView(.horizontal){
          HStack(alignment: .center, spacing: 20){
            SocialLink(
              name: "facebook",
              bgColor: Color.fbBlueBackground,
              link: user.facebook ?? "",
              isEditable: isOwnProfile
            )
            SocialLink(
              name: "twitter",
              bgColor: Color.twitterBlueBackground,
              link: user.twitter ?? "",
              isEditable: isOwnProfile
            )
            SocialLink(
              name: "linkedin",
              bgColor: Color.backgroundBlueGray,
              link: user.linkedin ?? "",
              isEditable: isOwnProfile
            )
            SocialLink(
              name: "instagram",
              bgColor: Color.igPurpleBackground,
              link: user.instagram ?? "",
              isEditable: isOwnProfile
            )
        
            SocialLink(
              name: "reddit",
              bgColor: Color.redditRedBackground,
              link: user.reddit ?? "",
              isEditable: isOwnProfile
            )
          
            SocialLink(
              name: "spotify",
              bgColor: Color.spotifyGreenBackground,
              link: user.spotify ?? "",
              isEditable: isOwnProfile
            )
            
          }
          .padding(.top, 3)

        }

        
      }
      
      .padding(.top, 20)

    }
}
