import Foundation
import SwiftUI

struct SigninView : View {
    @ObservedObject var signinViewModel = SigninViewModel()
    @EnvironmentObject var session: SessionStore
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                VStack(alignment: .center, spacing: 12) {
                    
                    Text("Welcome Back")
                        .fontWeight(.bold)
                    
                }
                
      
            }
            .padding(.horizontal,25)
            .padding(.top,30)
            
            VStack(alignment: .leading, spacing: 35) {
            
                EmailTextField(email: $signinViewModel.email)
                PasswordTextField(password: $signinViewModel.password)
                
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            // Login Button....
            
            SigninButton(
             action: signinViewModel.signin,
             label: TEXT_SIGN_IN
            )
            .padding(.horizontal,25)
            .padding(.top,25)
            .alert(isPresented: $signinViewModel.isAlertShown) {
                 Alert(
                     title: Text("Something went wrong..."),
                     message: Text(self.signinViewModel.errorString),
                     dismissButton: .default(Text("OK"))
                 )
             }
        }.onTapGesture(perform: dismissKeyboard)
        .onAppear{
            if (!session.isLoggedIn) {
                logToAmplitude(event: .viewLoginScreen)
            }
        }
    }
}
