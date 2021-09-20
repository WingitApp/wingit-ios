//
//  OnboardingView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/9/21.
//

import SwiftUI

struct OnboardingView: View {
    @State var shouldShowOnboarding: Bool = true
    
    var body: some View {
        // For Smaller Size iPhones...
        
        VStack{
            if UIScreen.main.bounds.height < 750{
                ScrollView(.vertical, showsIndicators: false) {
                    Home1()
                }
            }
            else{
                
                Home1()
            }
        }
        .padding(.vertical)
    }
}

struct NewOnboardingUI_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}


struct Home1 : View {
    
    @State var index = 0
    @Namespace var name
    
    var body: some View{
        
        VStack{
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
            
            HStack(spacing: 0){
                
                Button(action: {
                    
                    withAnimation(.spring()){
                        
                        index = 0
                    }
                    
                }) {
                    
                    VStack{
                        
                        Text("Login")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? .black : .gray)
                        
                        ZStack{
                            
                            // slide animation....
                            
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame( height: 4)
                            
                            if index == 0{
                                
                                Capsule()
                                    .fill(Color("Color"))
                                    .frame( height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
                
                Button(action: {
                    
                    withAnimation(.spring()){
                        
                        index = 1
                    }
                    
                }) {
                    
                    VStack{
                        
                        Text("Sign Up")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? .black : .gray)
                        
                        ZStack{
                            
                            // slide animation....
                            
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame( height: 4)
                            
                            if index == 1{
                                
                                Capsule()
                                    .fill(Color("Color"))
                                    .frame( height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
            .padding(.top,30)
            
            // Login View...
            
            // Changing Views Based On Index...
            
            if index == 0{
                SigninView()
            }
            else{
                SignupView()
            }
        }
    }
}
