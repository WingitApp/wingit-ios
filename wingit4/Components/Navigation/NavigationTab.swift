//
//  NavigationTab.swift
//  wingit4
//
//  Created by Joshua Lee on 8/18/21.
//

import SwiftUI

struct NavigationTab: View {
    var tag: Int
    var icon: String
    var screen: AnyView
    
    var body: some View {
        screen
            .tabItem({Image(systemName: icon)})
            .tag(tag)
    }
}
