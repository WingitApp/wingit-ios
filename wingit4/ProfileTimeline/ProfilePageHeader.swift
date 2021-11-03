//
//  HeaderProgress.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct ProfilePageHeader: View {
  
  var pageTitle: String = "Page Title"
  var pageSummary: String = "Page Summary"
  var isHorizontal: Bool = false
  
    var body: some View {
      
    
      VStack(alignment: .leading, spacing: 3) {
        HStack{
        Text(pageTitle)
        .bold()
        .font(.subheadline)
          Spacer()
          Image(systemName: "ellipsis")
          .rotationEffect(.degrees(isHorizontal ? 0 : -90))
          .foregroundColor(.gray)
          .padding(.vertical, 10)
        }
      
        Text(pageSummary)
          .font(.caption)
      
      }
      .padding(.horizontal, 5)
      .padding(.vertical, 5)
    }
}

struct PageHeader_Previews: PreviewProvider {
    static var previews: some View {
       ProfilePageHeader()
    }
}
