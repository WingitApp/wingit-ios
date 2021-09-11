//
//  Button.swift
//  wingit4
//
//  Created by Joshua Lee on 9/10/21.
//

import SwiftUI

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
