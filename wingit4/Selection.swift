//
//  Selection.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI

enum Selection: Int, CaseIterable, Identifiable {
    case friends
    case globe
    
    var id: UUID {
        return UUID()
    }
    
    var image: Text {
        switch self {
        case .friends:
            return Text("Asks")
        case .globe:
            return Text("Recommendations")
        }
    }
}
