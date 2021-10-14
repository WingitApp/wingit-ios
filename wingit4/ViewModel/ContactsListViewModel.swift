//
//  ContactsListViewModel.swift
//  wingit4
//
//  Created Daniel Yee on 9/17/21.
//

import Contacts
import Firebase
import FirebaseAuth
import Foundation
import SwiftUI

class ContactsListViewModel: ObservableObject {
  @Published var newContact = CNContact()
  @Published var contacts: [Contact] = []
  @Published var showNewContact = false // --> This is for the modal
  @Published var noPermission = false // --> Also, we should display a hint when the user hasn't granted permission so they know what's going on
  @Published var searchText = "" // --> this is for searching for contacts
  @Published var isLinkActive = false


  func fetch() {
      Api.Contacts.getSystemContacts { (contacts, error) in
          guard error == nil else {
              self.contacts = []
              self.noPermission = true
              return
          }
          self.contacts = contacts
      }
  }
  
  func showContactsList() {
      self.isLinkActive.toggle()
  }

  func contactFilter(contact: Contact) -> Bool {
      if self.searchText.count == 0 {
          return true
      }

      return contact.fullName().localizedCaseInsensitiveContains(self.searchText)
  }
  
  func sendMessage(numberToMessage: String) {
    guard let userIdPrefix = Auth.auth().currentUser?.uid.prefix(6) else { return }
    let referralCode = String(userIdPrefix)
    let inviteCodeQueryItem = URLQueryItem(name: "referralCode", value: referralCode)
    var components = URLComponents()
    components.scheme = Constants.HTTPS
    components.host = Constants.DYNAMIC_LINKS_DOMAIN
    components.path = Constants.INVITE_PATH
    components.queryItems = [inviteCodeQueryItem]
    
    guard let linkParameter = components.url else { return }
    
    let linkBuilder = DynamicLinkComponents(link: linkParameter, domainURIPrefix: "\(Constants.HTTPS)://\(Constants.DYNAMIC_LINKS_DOMAIN)")
    if let wingitBundleId = Bundle.main.bundleIdentifier {
      linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: wingitBundleId)
    }
    linkBuilder?.iOSParameters?.appStoreID = APPSTOREID
    linkBuilder?.socialMetaTagParameters?.title = "Exclusive Invite Link"
    linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: LOGO_URL)
    guard let longDynamicLink = linkBuilder?.url else { return }
    linkBuilder?.shorten { [weak self] url, warnings, error in
      if let error = error {
        print("DynamicLink shortening error: \(error)")
        return
      }
      if let warnings = warnings {
        for warning in warnings {
          print("Dynamic Link warning: \(warning)")
          print(longDynamicLink)
        }
        print("I have a short URL to share! \(String(describing: url?.absoluteString))")
      }
      guard let url = url else { return }
      let message = "I am inviting you to an exclusive new app called Wingit! Follow my referral link to join: \(url.absoluteString)"
      self?.shareSMS(numberToMessage: numberToMessage, message: message)
      print("I have a short dynamic link URL to share!  \(url.absoluteString)")
    }
  }
  
  func shareSMS(numberToMessage: String, message: String) {
    let sms: String = "sms:\(numberToMessage)&body=\(message)"
    let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
  }
}
