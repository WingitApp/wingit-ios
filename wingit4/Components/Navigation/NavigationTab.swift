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
    var view: AnyView
    
    var body: some View {
        view
            .tabItem({Image(systemName: icon)})
            .tag(tag)
    }
}
