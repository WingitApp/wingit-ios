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
    case viewLoginScreen = "View Login Screen"
    case loginAttempt = "Login Attempt"
    case userLogin = "User Login"
    
    case viewSignupScreen = "View Signup Screen"
    case signupAttempt = "Signup Attempt"
    case userSignup = "User Signup"
    
    // Navigation
    case viewComments = "View Comments"
    case viewHomeScreen = "View Home Screen"
    case viewDiscoverScreen = "View Discover Screen"
    case viewComposePostScreen = "View Compose Post Screen"
    case viewNotifications = "View Notifications"
    case viewOwnProfile = "View Own Profile"
    case userLogout = "User Logout"
    
    // Asks
    case commentOnAsk = "Comment On Ask"
    case postAsk = "Post Ask"
    case markAskAsClosed = "Mark Ask Closed"
    case reopenAsk = "Reopen Ask"
    case viewHomeAsksFeed = "View Home Asks Feed"
    case viewOwnOpenAsks = "View Own Open Asks"
    case viewOtherUsersClosedAsks = "View Other User's Closed Asks"
    case viewOwnClosedAsks = "View Own Closed Asks"
    
    // Referrals
    case ignoreReferral = "Ignore Referral"
    case tapWingReferralButton = "Tap Wing Referral Button"
    
    // Recs
    case commentOnRec = "Comment On Rec"
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
    case disconnect = "Disconnect"
    case ignoreConnectRequest = "Ignore Connect Request"
    case searchForFriends = "Search For Friends"
    case sendConnectRequest = "Send Connect Request"
    case upvote = "Upvote"
    case viewConnectionsList = "View Connections List"
    case viewOtherProfile = "View Other Profile"
    
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
    case attachedPhoto = "attached photo"
    case fromUser = "from user"
    case method = "method"
    case platform = "platform"
    case toUser = "to user"
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

  func logToAmplitude(event: AmplitudeEvent, properties: [AmplitudeProperty: Any]) {
      Amplitude.instance().logEvent(event.rawValue, withEventProperties:
          Dictionary(uniqueKeysWithValues: properties.map { (key, value) in (key.rawValue, value) }))
  }

  func addToUserProperty(property: AmplitudeUserProperty, value: Any) {
      AMPIdentify().add(property.rawValue, value: value as? NSObject)
  }

func setUserProperty(property: AmplitudeUserProperty, value: Any) {
    AMPIdentify().set(property.rawValue, value: value as? NSObject)
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

