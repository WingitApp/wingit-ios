//
//  AskDetailCard.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailCard: View {
  @Binding var post: Post
  
    var body: some View {
      VStack(alignment: .leading) {
        AskDetailHeader(post: $post)
        AskDetailBody(post: $post)
//        AskDetailRow(post: $post)
        AskDetailFooter(post: $post)
      }
    }
}
