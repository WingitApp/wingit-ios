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
        
        VStack(spacing: 0) {
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
                Spacer()
                Text("Please write down what the issue was").foregroundColor(.gray)
                Spacer()
            }
            TextEditor(text: $composedMessage)
                .cornerRadius(15)
                .padding()
             Button(action: reportAction) {
                    Text("Submit")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemTeal))
                        .cornerRadius(8)
             }.padding(.vertical).padding(.horizontal)

        }
        .preferredColorScheme(.light)
    }
}

//struct DoneReportInput: View {
//
//    @EnvironmentObject var session: SessionStore
//    @Environment(\.presentationMode) var presentationmode
//    @ObservedObject var reportInputViewModel = ReportInputViewModel()
//    var userId = Auth.auth().currentUser?.uid
//
//    @State var composedMessage: String = ""
//
//    init(donepost: DonePost?, postId: String?) {
//        if donepost != nil {
//            reportInputViewModel.donepost = donepost
//        } else {
//            handleInputViewModel(postId: postId!)
//        }
//    }
//
//    func handleInputViewModel(postId: String) {
//        Api.Post.loadDonePost(postId: postId) { (donepost) in
//            self.reportInputViewModel.donepost = donepost
//        }
//    }
//
//    func reportAction() {
//        if !composedMessage.isEmpty {
//            reportInputViewModel.addDoneReports(text: composedMessage) {
//                self.composedMessage = ""
//            }
//        }
//    }
//
//    var body: some View {
//
//        VStack(spacing: 0) {
//            HStack{
//                Button(action: {presentationmode.wrappedValue.dismiss()},
//                       label: { Text("Cancel")}).padding()
//                Spacer()
//                Text("Please write down what the issue was").foregroundColor(.gray)
//                Spacer()
//            }
//            TextEditor(text: $composedMessage)
//                .cornerRadius(15)
//                .padding()
//             Button(action: reportAction) {
//                    Text("Submit")
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                        .padding(.vertical)
//                        .frame(maxWidth: .infinity)
//                        .background(Color(.systemTeal))
//                        .cornerRadius(8)
//             }.padding(.vertical).padding(.horizontal)
//
//        }
//    }
//}






