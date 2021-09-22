//
//  MessagesViewController.swift
//  wingit4
//
//  Created by Daniel Yee on 9/21/21.
//

import Foundation
import MessageUI

protocol MessagesViewDelegate {
    func messageCompletion(result: MessageComposeResult)
}

class MessagesViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    var delegate: MessagesViewDelegate?
    var recipients: [String]?
    var body: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface
        composeVC.recipients = self.recipients ?? []
        composeVC.body = body ?? ""
        
        // Present the view controller modally
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            self.delegate?.messageCompletion(result: MessageComposeResult.failed)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
        self.delegate?.messageCompletion(result: result)
    }
}
