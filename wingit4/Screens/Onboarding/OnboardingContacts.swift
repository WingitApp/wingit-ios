//
//  OnboardingContacts.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/19/21.
//

import SwiftUI

struct OnboardingContacts: View {
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    
    var body: some View {
        ZStack{
            GeometryReader{proxy in
                
                let size = proxy.size
                
                // since for opacity animation...
                Color.black
       
                    
                    Image("Pic2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                       
                
                
//                 Linear Gradient...
                        .background(  LinearGradient(
                    gradient: Gradient(
                        colors: [.clear,
                                 .black.opacity(0.5),
                                 .black]),
                    startPoint: .top,
                    endPoint: .bottom)
                    )
        
            }
            .ignoresSafeArea()
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
            NavigationLink(destination: MainView()) {
                Text("Skip Step")
                    .foregroundColor(Color("Color"))
                    .bold()
                    .font(.system(size: 16))
                    .padding(.top)
            }
           
            .navigationTitle("Invite friends")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .simultaneousGesture(
                TapGesture().onEnded {
                    shouldShowOnboarding = false
                }
            )
        }
        }
    }
}

struct ContactsOnboarding_Previews: PreviewProvider {
    @State static var shouldShowOnboarding = true
    
    static var previews: some View {
        OnboardingContacts()
    }
}
