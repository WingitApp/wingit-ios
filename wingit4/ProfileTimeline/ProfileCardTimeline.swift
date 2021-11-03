//
//  ProfileCardTimeline.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/2/21.
//

import SwiftUI

struct ProfileCardTimeline: View {
    var body: some View {
      HStack{
      TimelineDates()
        VStack{
          ProfilePageCard()
          QuestionCard()
        }
    }
    }
}

struct ProfileCardTimeline_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardTimeline()
    }
}
