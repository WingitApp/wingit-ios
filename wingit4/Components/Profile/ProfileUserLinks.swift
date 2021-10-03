//
//  ProfileUserLinks.swift
//  wingit4
//
//  Created by Joshua Lee on 10/1/21.
//

import SwiftUI

struct ProfileUserLinks: View {
  
  
  // todo: if nill, then set opacity
    var body: some View {
      VStack(alignment: .leading, spacing: 0){
        ScrollView(.horizontal){
          HStack(alignment: .center, spacing: 20){
            SocialLink(
              name: "fb",
              bgColor: Color.fbBlueBackground
            )
            SocialLink(
              name: "instagram",
              bgColor: Color.igPurpleBackground
            )
        
            SocialLink(
              name: "twitter",
              bgColor: Color.twitterBlueBackground
            )
            SocialLink(
              name: "linkedin",
              bgColor: Color.backgroundBlueGray
            )
            SocialLink(
              name: "reddit",
              bgColor: Color.redditRedBackground
            )
          
            SocialLink(
              name: "spotify",
              bgColor: Color.spotifyGreenBackground
            )
            
          }
          .padding(.top, 3)

        }

        
      }
      
      .padding(.top, 20)
    }
}
