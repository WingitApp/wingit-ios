//
//  Api.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation

class Api {
    static var User = UserApi()
    static var Post = PostApi()
    static var Comment = CommentApi()
    static var Chat = ChatApi()
    static var Activity = ActivityApi()
    static var gemPost = gemPostApi()
    static var Report = ReportApi()
    static var Connections = ConnectionsApi()
}
