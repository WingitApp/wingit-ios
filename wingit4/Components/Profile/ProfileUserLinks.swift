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
        
        HStack(alignment: .center, spacing: 20){
          SocialLink(
            name: "fb",
            bgColor: Color.fbBlueBackground
          )
          SocialLink(
            name: "twitter",
            bgColor: Color.twitterBlueBackground
          )
          SocialLink(
            name: "reddit",
            bgColor: Color.redditRedBackground
          )
          SocialLink(
            name: "linkedin",
            bgColor: Color.backgroundBlueGray
          )
          SocialLink(
            name: "spotify",
            bgColor: Color.spotifyGreenBackground
          )
          
        }
        .fixedSize(horizontal: true, vertical: false)
      }
      
      .padding(.top, 20)
    }
}
