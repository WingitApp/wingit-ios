//
//  CommentActionEntry.swift
//  wingit4
//
//  Created by Joshua Lee on 10/8/21.
//

import SwiftUI

struct CommentActionEntry: View {
  
    var icon: String = "square.and.pencil"
    var label: String = "Edit Comment"
    var showDivider: Bool = false
    var onTap: (() -> Void)? = nil
    var isShown: Bool = false
  
    func onTapGesture() {
      guard let callback = onTap else { return }
      callback()
    }
  
  func getIconColor() -> Color {
    switch(icon) {
      case "trash":
        return Color.red

      default:
        return Color.wingitBlue
    }
  }
  
    var body: some View {
      if isShown {
        Button(action: {}) {
          VStack(spacing: 0){
            HStack {
              Text(Image(systemName: icon))
                .font(.body)
                .fontWeight(.light)
                .font(.system(size: 23))
                .frame(width: 30)
                .foregroundColor(getIconColor())

              Text(label)
                .font(.body)
                .foregroundColor(icon == "trash" ? Color.red : Color.black)
              Spacer()
            }
            .padding(.vertical, 15)
            .padding(.horizontal)
            .background(BackgroundBlurView())
            .frame(width: UIScreen.main.bounds.width)
            .onTapGesture {
              onTapGesture()
            }
          }
          
        }
        .buttonStyle(PlainButtonStyle())
      }
      
    }
}
