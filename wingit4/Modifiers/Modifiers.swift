//
//  Modifiers.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.padding()
            .border(COLOR_LIGHT_GRAY, width: 1)
            .padding([.top, .leading, .trailing])
    }
}

struct SigninButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.padding().background(Color(.systemTeal)).cornerRadius(5).shadow(radius: 10, x: 0, y: 10).padding()
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
