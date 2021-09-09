//
//  SignupButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI


struct SignupButton: View {
    var action: () -> Void
    var label: String
    var body: some View {
        Button(action: action) {
           
                Text(label)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                    
                        LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(8)
            
        }
    }
}
