//
//  MainViewModel.swift
//  wingit4
//
//  Created by Daniel Yee on 8/4/21.
//

import Amplitude
import Foundation
import Combine
import SwiftUI

final class MainViewModel: ObservableObject {

    var savedSelectedMainTabIndex: Int = 0
    
    @Published var selectedIndex: Int = 0 {
        didSet {
            savedSelectedMainTabIndex = selectedIndex
            switch selectedIndex {
            case 0:
                logToAmplitude(event: .viewHomeScreen)
            case 1:
                logToAmplitude(event: .viewDiscoverScreen)
            case 2:
                logToAmplitude(event: .viewComposePostScreen)
            case 3:
                logToAmplitude(event: .viewNotifications)
            case 4:
                logToAmplitude(event: .viewOwnProfile)
            default:
                break
            }
        }
    }
    
    init() {
        selectedIndex = savedSelectedMainTabIndex
    }
}
