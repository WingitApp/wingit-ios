//
//  OnboardingContacts.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/19/21.
//

import SwiftUI

struct OnboardingContacts: View {
//    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    
    @AppStorage("currentPage") var currentPage = 3
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Invite your friends")
                .fontWeight(.bold)
                .font(.system(size:30))
                .padding(.horizontal)
                .padding(.bottom, 50)
                .multilineTextAlignment(.center)
            NavigationLink(destination: ContactsListView()) {
                Text("Access your Contacts")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(
                       Color("Color")
                    )
                    .cornerRadius(8)
            }
            Button(action: {  withAnimation(.easeInOut){
                currentPage += 1
            } },
               label: {
                Text("Skip Step").foregroundColor(Color("Color"))
                    .bold()
                    .font(.system(size: 16))
                    .padding(.top)
            })
            .navigationTitle("Invite friends")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
//            .simultaneousGesture(
//                TapGesture().onEnded {
//                    shouldShowOnboarding = false
//                }
//            )
        }
    }
}

