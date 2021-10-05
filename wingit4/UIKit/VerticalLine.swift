//
//  VerticalLine.swift
//  wingit4
//
//  Created by Joshua Lee on 9/30/21.
//

import SwiftUI

struct VerticalLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}
