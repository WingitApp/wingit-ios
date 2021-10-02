//
//  ArcShape.swift
//  wingit4
//
//  Created by Joshua Lee on 9/30/21.
//

import SwiftUI

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}

struct ArcShape_Previews: PreviewProvider {
    static var previews: some View {
      Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
          .stroke(Color.blue, lineWidth: 10)
          .frame(width: 300, height: 300)
      
    }
}
