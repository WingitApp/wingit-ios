//import Foundation
//import SwiftUI
//
//struct SigninView : View {
//    @ObservedObject var signinViewModel = SigninViewModel()
//    @EnvironmentObject var session: SessionStore
//    
//    var body: some View{
//        NavigationView {
//            ZStack{
//                GeometryReader{proxy in
//                    
//                    let size = proxy.size
//                    
//                    // since for opacity animation...
//                    Color.black
//           
//                        
//                        Image("Pic1")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: size.width, height: size.height)
//                           
//                    
//                    
//    //                 Linear Gradient...
//                            .background(  LinearGradient(
//                        gradient: Gradient(
//                            colors: [.clear,
//                                     .black.opacity(0.5),
//                                     .black]),
//                        startPoint: .top,
//                        endPoint: .bottom)
//                        )
//            
//                }
//                .ignoresSafeArea()
//            VStack{
//                
//                HStack{
//                    
//                    VStack(alignment: .center, spacing: 12) {
//                        Text("Welcome Back")
//                            .fontWeight(.bold)
//                            .font(.system(size: 24))
//                    }
//                    
//          
//                }
//                .padding(.horizontal,25)
//                .padding(.top,30)
//                
//                VStack(alignment: .leading, spacing: 35) {
//                
//                    EmailTextField(email: $signinViewModel.email)
//                    PasswordTextField(password: $signinViewModel.password)
//                    
//                }
//                .padding(.horizontal,25)
//                .padding(.top,25)
//                
//                // Login Button....
//                
//                SigninButton(
//                 action: signinViewModel.signin,
//                 label: TEXT_SIGN_IN
//                )
//                .padding(.horizontal,25)
//                .padding(.top,25)
//                .alert(isPresented: $signinViewModel.isAlertShown) {
//                     Alert(
//                         title: Text("Something went wrong..."),
//                         message: Text(self.signinViewModel.errorString),
//                         dismissButton: .default(Text("OK"))
//                     )
//                 }
//                NavigationLink(destination: OnboardingTabView()) {
//                    Text("Sign Up for Wingit")
//                        .foregroundColor(.black)
//                        .bold()
//                        .font(.system(size: 16))
//                        .padding(.top)
//                }
//            }.onTapGesture(perform: dismissKeyboard)
//            .onAppear{
//                if (!session.isLoggedIn) {
//                    logToAmplitude(event: .viewLoginScreen)
//                }
//            }
//        }
//        }
//    }
//}
