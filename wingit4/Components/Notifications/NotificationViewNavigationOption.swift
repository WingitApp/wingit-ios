//
//  NotificationViewNavigationOptions.swift
//  wingit4
//
//  Created by Daniel Yee on 10/4/21.
//

import Foundation
import SwiftUI

enum NotificationLinkType { case askDetail, userProfile }

struct NotificationViewNavigationOption: View {
    @Binding var linkType: NotificationLinkType
    @Binding var post: Post?
    @Binding var userProfileId: String?

    @ViewBuilder
    var body: some View {
        switch linkType {
        case .askDetail:
            AskDetailView(post: $post)
        default:
            UserProfileView(userId: userProfileId, user: nil)
        }
    }
}
