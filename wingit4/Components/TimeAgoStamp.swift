//
//  Timestamp.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI

struct TimeAgoStamp: View {
  var date: TimeInterval
  
    var body: some View {
      Text(
        timeAgoSinceDate(
          Date(timeIntervalSince1970: date),
          currentDate: Date(),
          numericDates: true
        )
      ).modifier(CaptionStyle())
    }
}
