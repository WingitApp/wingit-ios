//
//  ReferFooter.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/2/21.
//

import SwiftUI

struct ReferFooter: View {
    var body: some View {
        HStack(spacing: 40){
            AcceptButton()
            BumpButton()
        }
    }
}

struct AcceptButton: View {
    var body: some View {
        Button(action: {},
               label: {
                VStack{
                    Text("Accept")
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 300, height: UIScreen.main.bounds.width / 9)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5),lineWidth: 1.5))
        })

    }
}

struct BumpButton: View {
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
               label: {
                VStack{
                    Text("Bump")
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 300, height: UIScreen.main.bounds.width / 9)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5),lineWidth: 1.5))
        })

    }
}

