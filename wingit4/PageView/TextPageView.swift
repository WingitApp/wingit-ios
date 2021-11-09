//
//  TextPageView.swift
//  wingit4
//
//  Created by Amy Chun on 11/8/21.
//

import SwiftUI

struct TextPageView: View {
    var body: some View {
      ZStack {
        VStack {
        Image("Pic3")
          .resizable()
          .frame(width: .infinity, height: 300)
          Spacer()
        }.ignoresSafeArea()
       
        VStack {
        HStack {
          Spacer()
          TextPage()
        }
          Spacer()
        }.padding(.top, 175)
      }
    }
}

struct TextPageView_Previews: PreviewProvider {
    static var previews: some View {
        TextPageView()
    }
}
