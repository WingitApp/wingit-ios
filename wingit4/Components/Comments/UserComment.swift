//
//  Comment.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct UserComment: View {
  var comment: Comment
  
  
    var body: some View {
      HStack(alignment: .top) {
        NavigationLink(
          destination: UserProfileView(userId: comment.ownerId, user: nil)
        ) {
          URLImageView(urlString: comment.avatarUrl)
            .clipShape(Circle())
            .frame(width: 35, height: 35, alignment: .center)
            .foregroundColor(Color(.systemTeal))
            .overlay(
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 0.5)
            )
        }
        .buttonStyle(PlainButtonStyle())
        VStack(alignment: .leading) {
          HStack(alignment: .center) {
            Text(comment.username)
              .font(.caption)
              .fontWeight(.semibold)
            Circle()
              .modifier(CircleDotStyle())
            Text(
              timeAgoSinceDate(
                Date(timeIntervalSince1970: comment.date),
                currentDate: Date(),
                numericDates: true
              )
            )
              .foregroundColor(.gray)
              .font(.system(size: 10))
          }
            TextViewWrapper(
                attributedText: NSAttributedString(
                    string: comment.comment
                )
            )
        }
        .padding(.leading, 10)

      }
      .padding(
        EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
      )
      Divider()
    }
}

struct TextViewWrapper: UIViewRepresentable {
    var attributedText: NSAttributedString
    
    func makeUIView(context: Context) -> UITextView {
        let uiView = UITextView(frame: .zero)
        
        uiView.backgroundColor = .clear
        uiView.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        uiView.isSelectable = true
        uiView.isEditable = false
        uiView.isScrollEnabled = false
        uiView.isUserInteractionEnabled = true
        uiView.dataDetectorTypes = .link
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return uiView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedText
    }
}
