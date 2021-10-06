//
//  BoardingScreen.swift
//  wingit4
//
//  Created by Amy Chun on 10/6/21.
//

import SwiftUI

struct BoardingScreen: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
}

// Same Title and desc...
let title1 = "Connect with Friends"
let description1 = "Start with your first connections"

let title2 = "Ask for recommendations, advice, and assistance."
let description2 = "Receive personalized help through your first connections and their friends."

let title3 = "Wing Posts and get the chain started!"
let description3 = "Refer friends with subject matter expertise on asks as they also wing their circle of friends."

let image = "logo"

// Since image name and BG color name are same....

// Sample Model SCreens....
var boardingScreens: [BoardingScreen] = [

    BoardingScreen(image: image, title: title1, description: description1),
    BoardingScreen(image: image, title: title2, description: description2),
    BoardingScreen(image: image, title: title3, description: description3), 
]


/*
 Connect with Friends
 Start with your first connections

 Ask for recommendations, advice, and assistance.
 Receive personalized help through your first connections and their friends.

 Wing Posts and get the chain started!
 Refer friends with subject matter expertise on asks as they also wing their circle of friends.
 */
