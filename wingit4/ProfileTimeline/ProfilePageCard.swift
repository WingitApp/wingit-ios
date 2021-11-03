//
//  ProgressCard.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct ProfilePageCard: View {
  
    var body: some View {
      
      VStack(spacing: 3) {
        
        
        ProfilePageHeader(pageSummary: "testing to see what happens when long.fdjksalfjdkl;asjfkdl;sajfkdl;asjklf;dsajfkdls;ajfkld;sajkfl;djsaklf;dsa")
       Image("Pic3")
          .resizable()
          .aspectRatio(contentMode: .fill)
      }
      .frame(width: 350, height: 325)
      .cornerRadius(10)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color.gray, lineWidth: 0.3)
      )
    }
}

struct ProfilePageCard_Previews: PreviewProvider {
    static var previews: some View {
       ProfilePageCard()
    }
}
