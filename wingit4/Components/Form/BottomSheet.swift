//
//  BottomSheet.swift
//  wingit4
//
//  Created by Joshua Lee on 9/25/21.
//

import SwiftUI

struct BottomSheet: View {
  
  @State var offset: CGFloat = 0
  @State var showSheet: Bool = true
    var body: some View {
      VStack {
        Spacer()
        VStack(spacing: 18) {
          Capsule()
            .fill(Color.gray)
            .frame(width: 60, height: 4)
          Text("Placeholder Text")
          ScrollView(showsIndicators: false) {
            
          }
          .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height / 3
          )
        }
        .padding(.top)
        .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
        .offset(y: offset)
        .offset(y: showSheet ? 0 : UIScreen.main.bounds.height)
      }
      .ignoresSafeArea()
      .background(Color.black.opacity( showSheet ? 0.3 : 0).ignoresSafeArea())
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}
