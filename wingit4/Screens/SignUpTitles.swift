//
//  SignUpTitles.swift
//  wingit4
//
//  Created by Amy Chun on 10/16/21.
//

import SwiftUI

struct SignUpTitles: View {
  
  var title: String
  var subtitle: String?
  
    var body: some View {
  
        VStack(alignment: .leading, spacing: 15){
        Text(title).bold().font(.title2)
        Text(subtitle ?? "").font(.caption).foregroundColor(.gray)
        Spacer()
          
        }.padding(.top, 100)
        .padding(.leading, 25)
      
    }
}

