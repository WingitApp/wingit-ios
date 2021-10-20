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
  
  func sendMessage(numberToMessage: String, currentUser: User?) {
    guard let currentUser = currentUser else { return }
    generateInviteLink(currentUser: currentUser) { [weak self] url in
      let message = "I am inviting you to an exclusive app called Wingit! Follow this personal referral link to join:\n\(url)"
      self?.shareSMS(numberToMessage: numberToMessage, message: message)
    }
  }
  
  func shareSMS(numberToMessage: String, message: String) {
    let sms: String = "sms:\(numberToMessage)&body=\(message)"
    let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
  }
  
  func generateInviteLink(currentUser: User?, onComplete: @escaping(_ url: String) -> Void) {
    var components = URLComponents()
    components.scheme = Constants.HTTPS
    components.host = Constants.DYNAMIC_LINKS_DOMAIN
    components.path = Constants.INVITE_PATH
    
    if let inviterId = currentUser?.id {
      let inviterQueryItem = URLQueryItem(name: "inviterId", value: inviterId)
      components.queryItems = [inviterQueryItem]
    }
    
    guard let linkParameter = components.url else { return onComplete(APP_STORE_LINK) }
    
    let linkBuilder = DynamicLinkComponents(link: linkParameter, domainURIPrefix: "\(Constants.HTTPS)://\(Constants.DYNAMIC_LINKS_DOMAIN)")
    if let wingitBundleId = Bundle.main.bundleIdentifier {
      linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: wingitBundleId)
    }
    linkBuilder?.iOSParameters?.appStoreID = APPSTOREID
    linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
    linkBuilder?.socialMetaTagParameters?.title = "\(currentUser?.displayName ?? "Your friend") invited you to Wingit!"
    linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: currentUser?.profileImageUrl ?? LOGO_URL)
    linkBuilder?.shorten { url, warnings, error in
      if let error = error {
        print("DynamicLink shortening error: \(error)")
        onComplete(linkBuilder?.url?.absoluteString ?? APP_STORE_LINK)
        return
      }
      if let warnings = warnings {
        for warning in warnings {
          print("Dynamic Link warning: \(warning)")
        }
      }
      onComplete(url?.absoluteString ?? APP_STORE_LINK)
    }
  }
}
