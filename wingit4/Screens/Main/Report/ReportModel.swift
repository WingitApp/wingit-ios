//
//  ReportModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/2/21.
//

import Foundation

struct Report: Encodable, Decodable, Identifiable {
    var id = UUID()
    var comment: String
    var ownerId: String
    var postId: String
    var username: String
}
