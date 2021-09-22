//
//  ContactItem.swift
//  wingit4
//
//  Created by Daniel Yee on 9/17/21.
//

import Foundation
import SwiftUI

struct ContactItem: View {
    var contact: Contact

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Text(contact.firstName)
                    Text(contact.lastName)
                    Spacer()
                    Image(systemName: "person.fill.badge.plus").foregroundColor(.gray)
                }
            }
        }
    }
}
