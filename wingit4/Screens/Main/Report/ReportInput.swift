//
//  ReportInput.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/2/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct ReportInput: View {
    
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationmode
    @ObservedObject var reportInputViewModel = ReportInputViewModel()
    var userId = Auth.auth().currentUser?.uid
    
    @State var composedMessage: String = ""
    
    init(post: Post?, postId: String?) {
        if post != nil {
            reportInputViewModel.post = post
        } else {
            handleInputViewModel(postId: postId!)
        }
    }
    
    func handleInputViewModel(postId: String) {
        Api.Post.loadPost(postId: postId) { (post) in
            self.reportInputViewModel.post = post
        }
    }
    
    func reportAction() {
        if !composedMessage.isEmpty {
            reportInputViewModel.addReports(text: composedMessage) {
                self.composedMessage = ""
            }
        }
    }
    
    var body: some View {
        NavigationView{
        VStack(spacing: 0) {
          
//                Button(action: {presentationmode.wrappedValue.dismiss()},
//                       label: { Text("Cancel")}).padding()
            Group{
            Text("Help us understand the problem. What is going on with this post?")
                .foregroundColor(.gray)
                .padding(.top, 75)
                .padding(.horizontal)
            TextEditor(text: $composedMessage)
                .cornerRadius(15)
                .padding(20)
                .onTapGesture(perform: dismissKeyboard)
             Button(action: reportAction) {
                    Text("Submit")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.wingitBlue)
                        .cornerRadius(8)
             }.padding(.vertical).padding(.horizontal)
            }
        }
        .navigationBarTitle("Report an issue", displayMode: .inline)
        .edgesIgnoringSafeArea([.top, .bottom])
       
        }
        .preferredColorScheme(.light)
    }
}








