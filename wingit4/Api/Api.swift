//
//  Api.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation

class Api {
    static var Activity = ActivityApi()
    static var Ask = AskApi()
    static var Chat = ChatApi()
    static var Comment = CommentApi()
    static var Connections = ConnectionsApi()
    static var Contacts = ContactsService()
    static var Device = DeviceApi()
    static var Post = PostApi()
    static var Referrals = ReferralsApi()
    static var Report = ReportApi()
    static var User = UserApi()
}
