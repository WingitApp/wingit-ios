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
  
    var body: some View {
      if isShown {
        Button(action: onTapGesture) {
          VStack(spacing: 0){
  //          if showDivider { Divider() }
            HStack {
              Text(Image(systemName: icon))
                .font(.body)
                .fontWeight(.light)
                .font(.system(size: 20))
                .frame(width: 30)
                .foregroundColor(icon == "trash" ? Color.red : Color.wingitBlue)

              Text(label)
                .font(.body)
                .foregroundColor(icon == "trash" ? Color.red : Color.black)
              Spacer()
            }
            .padding(.vertical, 15)
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width)
            
  //          if showDivider { Divider() }
          }
          
        }
        .buttonStyle(PlainButtonStyle())
      }
      
    }
}
