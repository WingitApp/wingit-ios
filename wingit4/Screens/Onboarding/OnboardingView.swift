//
//  OnboardingView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/9/21.
//

import SwiftUI

//struct OnboardingView: View {
//    @State private var tabSelection = 0
//    @StateObject var signupViewModel = SignupViewModel()
//
//    var body: some View {
//        TabView (selection: $tabSelection) {
//            OnboardingSignupForm(tabSelection: $tabSelection).tag(0)
//            OnboardingProfilePhoto(selectedTab: $tabSelection).tag(1)
//            OnboardingContacts().tag(2)
//        }
//        .tabViewStyle(PageTabViewStyle())
//        .environmentObject(signupViewModel)
//    }
//}


struct WalkthroughScreen: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        
        // For Slide Animation...
        
        ZStack{
            
            // Changing Between Views....
            
            if currentPage == 1{
               OnboardingSignupForm()
                    .transition(.scale)
            }
            if currentPage == 2{
            
               OnboardingProfilePhoto()
                    .transition(.scale)
            }
            
            if currentPage == 3{
                
                OnboardingContacts()
                    .transition(.scale)
            }
            
        }
        .overlay(
        
            // Button...
            Button(action: {
                // changing views...
                withAnimation(.easeInOut){
                    
                    // checking....
                    if currentPage <= totalPages{
                        currentPage += 1
                    }
                }
            }, label: {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                // Circlular Slider...
                    .overlay(
                    
                        ZStack{
                            
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                                
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom,20)
            
            ,alignment: .bottom
        )
    }
}

// total Pages...
var totalPages = 3

//struct ScreenView: View {
//
//    var image: String
//    var title: String
//    var detail: String
//    var bgColor: Color
//
//    @AppStorage("currentPage") var currentPage = 1
//
//    var body: some View {
//        VStack(spacing: 20){
//
//            HStack{
//
//                // Showing it only for first Page...
//                if currentPage == 1{
//                    Text("Hello Member!")
//                        .font(.title)
//                        .fontWeight(.semibold)
//                        // Letter Spacing...
//                        .kerning(1.4)
//                }
//                else{
//                    // Back Button...
//                    Button(action: {
//                        withAnimation(.easeInOut){
//                            currentPage -= 1
//                        }
//                    }, label: {
//
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.white)
//                            .padding(.vertical,10)
//                            .padding(.horizontal)
//                            .background(Color.black.opacity(0.4))
//                            .cornerRadius(10)
//                    })
//                }
//
//                Spacer()
//
//                Button(action: {
//                    withAnimation(.easeInOut){
//                        currentPage = 4
//                    }
//                }, label: {
//                    Text("Skip")
//                        .fontWeight(.semibold)
//                        .kerning(1.2)
//                })
//            }
//            .foregroundColor(.black)
//            .padding()
//
//            Spacer(minLength: 0)
//
//            Image(image)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//
//            Text(title)
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(.black)
//                .padding(.top)
//
//            // Change with your Own Thing....
//            Text("You never know until you ask.")
//                .fontWeight(.semibold)
//                .kerning(1.3)
//                .multilineTextAlignment(.center)
//
//            // Minimum Spacing When Phone is reducing...
//
//            Spacer(minLength: 120)
//        }
//        .background(bgColor.cornerRadius(10).ignoresSafeArea())
//    }
//}


