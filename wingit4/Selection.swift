//
//  Selection.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI

enum Selection: Int, CaseIterable, Identifiable {
    case posts
    case globe
    case image
    
    var id: UUID {
        return UUID()
    }
    
    var label: Text {
        switch self {
        case .posts:
          return Text("Asks")
        case .image:
            return Text("Asks")
        case .globe:
            return Text("Recommendations")
        }
        
    }
}
