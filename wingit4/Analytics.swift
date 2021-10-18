//
//  Analytics.swift
//  wingit4
//
//  Created by Daniel Yee on 7/28/21.
//

import Amplitude
import Foundation

enum AmplitudeEvent: String {
    // Onboarding
    case acceptInvitation = "Accept Invitation"
    case viewLoginScreen = "View Login Screen"
    case loginAttempt = "Login Attempt"
    case userLogin = "User Login"
    
    case viewSignupScreen = "View Signup Screen"
    case signupAttempt = "Signup Attempt"
    case userSignup = "User Signup"
    
    // Navigation
    case viewComments = "View Comments"
    case viewHomeScreen = "View Home Screen"
    case viewReferralsScreen = "View Referrals Screen"
    case viewDiscoverScreen = "View Discover Screen"
    case viewComposePostScreen = "View Compose Post Screen"
    case viewNotifications = "View Notifications"
    case viewOwnProfile = "View Own Profile"
    case userLogout = "User Logout"
  
    // Profile
    case tapEditProfile = "Tap Edit Profile"
    
    // Asks
    case postAsk = "Post Ask"
    case postComment = "Post Comment"
    case markAskAsClosed = "Mark Ask As Closed"
    case reopenAsk = "Reopen Ask"
    case viewAskDetailScreen = "View Ask Detail Screen"
    case viewOtherUsersClosedAsks = "View Other User's Closed Asks"
    case viewOtherUsersOpenAsks = "View Other User's Open Asks"
    case viewOwnClosedAsks = "View Own Closed Asks"
    case viewOwnOpenAsks = "View Own Open Asks"
    case wingAsk = "Wing Ask"
    
    // Referrals
    case acceptReferralRequest = "Accept Referral Request"
    case ignoreReferral = "Ignore Referral"
    case tapWingReferralButton = "Tap Wing Referral Button"
    case rewingReferral = "Rewing Referral"
    
    // Recs
    case postRec = "Post Rec"
    case postRecError = "Post Rec Error"
    case viewOthersRecs = "View Others Recs"
    case viewOwnRecs = "View Own Recs"
    case viewHomeRecsFeed = "View Home Recs Feed"
    
    // Communication
    case tapMessageButton = "Tap Message Button"
    case viewMessages = "View Messages"
    
    // Social
    case acceptConnectRequest = "Accept Connect Request"
    case declineConnectRequest = "Decline Connect Request"
    case disconnectFromUser = "Disconnect From User"
    case referContact = "Refer Contact"
    case searchForFriends = "Search For Friends"
    case sendConnectRequest = "Send Connect Request"
    case tapInviteContacts = "Tap Invite Contacts"
    case tapSearchYourContacts = "Tap Search Your Contacts"
    case upvote = "Upvote"
    case viewConnectionsList = "View Connections List"
    case viewOtherUsersProfile = "View Other User's Profile"
    
    // Miscellaneous
    case appStart = "App Start"
}

enum AmplitudeUserProperty: String {
    case email = "Email"
    case connections = "Connections"
    case firstName = "First name"
    case lastName = "Last name"
    case signupDate = "Signup date"
    case signupMethod = "Signup method"
    case signupPlatform = "Signup platform"
    case username = "Username"
}

enum AmplitudeProperty: String {
    case askId = "askId"
    case attachedPhoto = "attached photo"
    case method = "method"
    case medium = "medium"
    case name = "name"
    case parentId = "parent id"
    case platform = "platform"
    case postId = "post id"
    case postType = "post type"
    case recipientId = "recipient id"
    case recipients = "recipients"
    case referralId = "referral id"
    case screen = "screen"
    case senderId = "sender id"
    case userId = "user id"
}

  func logToAmplitude(event: AmplitudeEvent) {
      Amplitude.instance().logEvent(event.rawValue)
  }

  func logToAmplitude(event: AmplitudeEvent, userId: String?) {
      let amplitude = Amplitude.instance()
      if let userId = userId {
          amplitude.setUserId(userId)
          amplitude.logEvent(event.rawValue)
      } else {
          amplitude.logEvent(event.rawValue)
          amplitude.setUserId(nil)
      }
  }

  func logToAmplitude(event: AmplitudeEvent, properties: [AmplitudeProperty: Any?]) {
      Amplitude.instance().logEvent(event.rawValue, withEventProperties:
          Dictionary(uniqueKeysWithValues: properties.map { (key, value) in (key.rawValue, value) }))
  }

  func addToUserProperty(property: AmplitudeUserProperty, value: Any) {
    guard let identify = AMPIdentify().add(property.rawValue, value: value as? NSObject) else { return }
    Amplitude.instance().identify(identify)
  }

func setUserProperty(property: AmplitudeUserProperty, value: Any) {
    guard let identify = AMPIdentify().set(property.rawValue, value: value as? NSObject) else { return }
    Amplitude.instance().identify(identify)
}

func setUserPropertiesOnAccountCreation(userId: String?, firstName: String?, lastName: String?, username: String?, email: String, signupMethod: String) {
    guard let userId = userId, let firstName = firstName, let lastName = lastName, let username = username else { return }
    let amplitude = Amplitude.instance()
    amplitude.setUserId(userId)
    guard let identify = AMPIdentify()
            .setOnce(AmplitudeUserProperty.signupDate.rawValue, value: NSString(string: Date.iso8601ShortDateString(date: Date())))
            .setOnce(AmplitudeUserProperty.email.rawValue, value: NSString(string: email))
            .setOnce(AmplitudeUserProperty.firstName.rawValue, value: NSString(string: firstName))
            .setOnce(AmplitudeUserProperty.lastName.rawValue, value: NSString(string: lastName))
            .setOnce(AmplitudeUserProperty.username.rawValue, value: NSString(string: username))
            .setOnce(AmplitudeUserProperty.signupMethod.rawValue, value: NSString(string: signupMethod))
            .set(AmplitudeUserProperty.connections.rawValue, value: NSNumber(value: 0)) else { return }
    amplitude.identify(identify)
}

