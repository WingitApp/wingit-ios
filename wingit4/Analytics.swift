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
    
    // Requests
    case commentOnRequest = "Comment On Request"
    case postRequest = "Post Request"
    case markRequestFulfilled = "Mark Request Fulfilled"
    case tapReferButton = "Tap Refer Button"
    case viewOwnRequests = "View Own Requests"
    case viewOthersRequests = "View Others Requests"
    case viewFulfilledRequests = "View Fulfilled Requests"
    case viewHomeRequestsFeed = "View Home Requests Feed"
    
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

func setUserPropertiesOnAccountCreation(userID: String, username: String, email: String, signupMethod: String) {
    let amplitude = Amplitude.instance()
    amplitude.setUserId(userID)
    guard let identify = AMPIdentify()
            .setOnce(AmplitudeUserProperty.signupDate.rawValue, value: NSString(string: Date.iso8601ShortDateString(date: Date())))
            .setOnce(AmplitudeUserProperty.username.rawValue, value: NSString(string: username))
            .setOnce(AmplitudeUserProperty.email.rawValue, value: NSString(string: email))
            .setOnce(AmplitudeUserProperty.username.rawValue, value: NSString(string: username))
            .setOnce(AmplitudeUserProperty.signupMethod.rawValue, value: NSString(string: signupMethod))
            .set(AmplitudeUserProperty.connections.rawValue, value: NSNumber(value: 0)) else { return }
    amplitude.identify(identify)
}

