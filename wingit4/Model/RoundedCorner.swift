//
//  RoundedCorner.swift
//  wingit4
//
//  Created by Joshua Lee on 9/10/21.
//

import SwiftUI

// Struct Shape
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
