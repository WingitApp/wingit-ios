//
//  RecButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/18/21.
//

import SwiftUI

struct RecButton: View {
    var body: some View {
        
        Button(action: {
            sendMessage()
        }, label: {
            HStack{
                Text("Refer someone you know")
                Text("🙏🏻")
              //  Text("💌")
            }.font(.caption)
        })
        
        Spacer()
    }
        func sendMessage (){
             let sms: String = "sms:Add #&body=https://apps.apple.com/us/app/winging/id1572569005"
             let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
             UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
            }
}

