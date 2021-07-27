//
//  CommentRow.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage

struct CommentRow: View {
    
    var comment: Comment
    
    var body: some View {
        HStack {
            URLImage(URL(string: comment.avatarUrl)!,
                                          content: {
                                              $0.image
                                                  .resizable()
                                                  .aspectRatio(contentMode: .fill)
                                                  .clipShape(Circle())
                                          }).frame(width: 35, height: 35)
            
            
             VStack(alignment: .leading) {
                Text(comment.username).font(.subheadline).bold()
                Text(comment.comment).font(.caption).padding(.top, 5)
             }
             Spacer()
            Text(timeAgoSinceDate(Date(timeIntervalSince1970: comment.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
         }.padding(.trailing, 15).padding(.leading, 15)
    }
}

//struct CommentRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentRow()
//    }
//}
