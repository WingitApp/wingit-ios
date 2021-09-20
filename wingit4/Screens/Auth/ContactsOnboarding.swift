//
//  ContactsOnboarding.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/19/21.
//

import SwiftUI

struct ContactsOnboarding: View {
    var body: some View {
        VStack(alignment: .center){
        Text("Invite your close friends!")
            .fontWeight(.bold)
            .font(.system(size:30))
            .padding(.horizontal)
            .padding(.bottom, 50)
            .multilineTextAlignment(.center)
            Button(action: {},
                   label: {
                Text("Access your Contacts")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                       Color("Color")
                    )
                    .cornerRadius(8)
            })
            Button(action: {},
                   label: {
                    Text("Skip Step").foregroundColor(Color("Color"))
                        .bold()
                        .font(.system(size: 12))
                        .padding(.top)
            })
        }
        
    }
}

struct ContactsOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        ContactsOnboarding()
    }
}
