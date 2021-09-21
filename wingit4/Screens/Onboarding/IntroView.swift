//
//  SignupView.swift
//  wingit4
//
//  Created by Daniel Yee on 9/20/21.
//

import Foundation
import SwiftUI

struct IntroView: View {
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text(TEXT_WINGIT)
                    .fontWeight(.bold)
                    .font(.system(size: 50))
                    .padding(.horizontal)
                    .padding(.top, -36)
                    .padding(.bottom, 80)
                    .multilineTextAlignment(.center)
                Image(IMAGE_LOGO).resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80).padding(.bottom, 24)
                Text(TEXT_INTRO_TAGLINE)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                    .multilineTextAlignment(.center)
                NavigationLink(destination: OnboardingView()) {
                    Text("Create an Account")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .background(
                           Color("Color")
                        )
                        .cornerRadius(8)
                }
                NavigationLink(destination: SigninView()) {
                    Text("Already have an account? Log In")
                        .foregroundColor(Color("Color"))
                        .bold()
                        .font(.system(size: 16))
                        .padding(.top)
                }
            }
        }
    }
}
