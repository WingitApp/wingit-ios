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
    var phoneNumber: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5) {
                Text("\(contact.firstName) \(contact.lastName)").font(.headline).bold()
                Text("\(phoneNumber)").font(.subheadline).foregroundColor(.gray)
            }
            .padding(.leading, 5)
            Spacer()
            Image(systemName: "plus.circle").foregroundColor(.gray)
        }
        .padding(
          EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)
        )
        .contentShape(Rectangle())
      }
}
