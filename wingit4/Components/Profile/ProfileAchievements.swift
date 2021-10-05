//
//  ProfileAchievements.swift
//  wingit4
//
//  Created by Joshua Lee on 10/1/21.
//

import SwiftUI

struct ProfileAchievements: View {
    var body: some View {
      HStack(alignment: .center){
        Text("🏆 Achievements")
          .font(.subheadline)

        Spacer()
        Text("See All")
          .font(.subheadline)

          .foregroundColor(Color.gray)
      }
      .frame(width: UIScreen.main.bounds.width - 30)
    }
}
