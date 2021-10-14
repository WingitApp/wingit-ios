//
//  ReactionUserCard.swift
//  wingit4
//
//  Created by Joshua Lee on 10/13/21.
//

import SwiftUI

struct ReactionUserCard: View {
  var reactor: UserPreview
  
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .center) {
          URLImageView(urlString: reactor.avatar)
            .clipShape(Circle())
            .frame(width: 35, height: 35, alignment: .center)
              .foregroundColor(Color.wingitBlue)
            .overlay(
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 0.5)
            )
          VStack(alignment: .leading, spacing: 0) {
            Text(reactor.displayName ?? "")
              .font(.body)
              .fontWeight(.semibold)
              .padding(.bottom, 5)
            Text(reactor.username ?? "")
              .font(.system(size:13))
          }
          .padding(.leading, 10)
         
          Spacer()
        }
        .padding([.horizontal, .vertical])
        
        .frame(width: UIScreen.main.bounds.width - 30)
        Divider()
      }
    }
}

