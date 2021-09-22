//
//  MessageUIView.swift
//  wingit4
//
//  Created by Daniel Yee on 9/21/21.
//

import Foundation
import MessageUI
import SwiftUI

struct MessageUIView: UIViewControllerRepresentable {
    
    // To be able to dismiss itself after successfully finishing with the MessagesUI
    @Environment(\.presentationMode) var presentationMode
    
    var recipients: [String]
    @Binding var body: String
    var completion: ((_ result: MessageComposeResult) -> Void)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> MessagesViewController {
        let controller = MessagesViewController()
        controller.delegate = context.coordinator
        controller.recipients = recipients
        controller.body = body
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MessagesViewController, context: Context) {
        uiViewController.recipients = recipients
        uiViewController.displayMessageInterface()
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, MessagesViewDelegate {
        var parent: MessageUIView
        
        init(_ controller: MessageUIView) {
            self.parent = controller
        }
        
        func messageCompletion(result: MessageComposeResult) {
            self.parent.presentationMode.wrappedValue.dismiss()
            self.parent.completion(result)
        }
    }
}
