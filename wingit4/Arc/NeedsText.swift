//
//  NeedsText.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct NeedsText: View {
  var needs: String = "List of to do's"
    var body: some View {
      Text(needs)
    }
}

struct NeedsText_Previews: PreviewProvider {
    static var previews: some View {
        NeedsText()
    }
}
