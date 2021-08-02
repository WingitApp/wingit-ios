//
//  Analytics.swift
//  wingit4
//
//  Created by Daniel Yee on 7/28/21.
//

import Amplitude
import Foundation

enum AmplitudeEvent: String {
    case appStart = "App Start"
    case loginAttempt = "Login Attempt"
    case loginScreen = "Login Screen"
    case signupAttempt = "Signup Attempt"
    case signupScreen = "Signup Screen"
    case userLogin = "User Login"
    case userLogout = "User Logout"
    case userSignup = "User Signup"
}

enum AmplitudeUserProperty: String {
    case email = "Email"
    case signupDate = "Signup date"
    case signupMethod = "Signup method"
    case signupPlatform = "Signup platform"
    case username = "Username"
}

enum AmplitudeProperty: String {
    case method = "method"
    case platform = "platform"
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

func setUserPropertiesOnAccountCreation(userID: String, username: String, email: String, signupMethod: String) {
    let amplitude = Amplitude.instance()
    amplitude.setUserId(userID)
    guard let identify = AMPIdentify()
            .setOnce(AmplitudeUserProperty.signupDate.rawValue, value: NSString(string: Date.iso8601ShortDateString(date: Date())))
            .setOnce(AmplitudeUserProperty.username.rawValue, value: NSString(string: username))
            .setOnce(AmplitudeUserProperty.email.rawValue, value: NSString(string: email))
            .setOnce(AmplitudeUserProperty.signupMethod.rawValue, value: NSString(string: signupMethod)) else { return }
    amplitude.identify(identify)
}

