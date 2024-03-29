//
//  AlertView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/6/21.
//

import SwiftUI

func alertView(msg: String, placeholder: String, completion: @escaping (String) -> ()){
    
    let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
    
    alert.addTextField { (txt) in
      if placeholder.isValidURL {
        txt.text = placeholder
      } else {
        txt.placeholder = "https://"
      }
    }
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
    
    alert.addAction(UIAlertAction(title: msg.contains("Verification") ? "Verify" : "Update", style: .default, handler: { (_) in
        
        let code = alert.textFields![0].text ?? ""
        
        if code == ""{
            // Repromoting..
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
            return
        }
        completion(code)
    }))
    
    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
}
