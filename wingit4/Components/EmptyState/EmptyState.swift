//
//  EmptyState.swift
//  wingit4
//
//  Created by Joshua Lee on 9/15/21.
//

import SwiftUI

struct EmptyState: View {
  
  var title: String
  var description: String
  var iconName: String
  var iconColor: Color
  var buttonLabel: String = ""
  var function: (() -> Void)?
  
  func onTapButton() {
    self.function!()
  }
  
    var body: some View {
        ZStack {
          AskCardPlaceholder()
            .foregroundColor(Color.lightGray)
            .blur(radius: 2)
            .zIndex(0)
            VStack(alignment: .center) {
              Image(systemName: "\(iconName)")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .padding(10)
                .background(
                  LinearGradient(
                    gradient: Gradient(
                      colors: [iconColor.lighter(by: 10), iconColor]),
                      startPoint: .top,
                      endPoint: .bottom
                    )
                )
                .cornerRadius(100)
                .frame(width: 50, height: 50)
                .shadow(
                  color: Color.black.opacity(0.3),
                  radius: 3, x: 0, y: 0.5
                )
              Text("\(title)")
                .font(.headline)
                .padding(.top, 10)
                .padding(.bottom, 3)
              Text("\(description)")
                .font(.callout)
                .fontWeight(.medium)
                .fixedSize(horizontal: false, vertical: true)
              if !buttonLabel.isEmpty {
                Button(action: onTapButton) {
                    Text("\(buttonLabel)")
                }
              }
            }
            .frame(width: UIScreen.main.bounds.width - 40)
            .offset(y: -20)
            .zIndex(1)

         
        }
    }
}
