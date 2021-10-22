//
//  Modifiers.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.borderGray, lineWidth: 1)
            )
        // shadow effect...
//            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
//            .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: -3)
    }
}

struct AcceptConnectRequestButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
          
            .frame(width: UIScreen.main.bounds.width - 325, height: UIScreen.main.bounds.width / 12)
            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.pink.opacity(0.5),lineWidth: 1.5))
    }
}

struct ProfileConnectButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(
              width: (UIScreen.main.bounds.width / 2) - 30
            )
            .padding(
              .init(top: 10, leading: 0, bottom: 10, trailing: 0)
            )
            .background(Color.lightGray)
            .foregroundColor(Color.black)
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5).stroke(Color(.lightGray),
              lineWidth: 1)
            )
    }
}


