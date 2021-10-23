//
//  StringExtensions.swift
//  wingit4
//
//  Created by Daniel Yee on 9/16/21.
//

import Foundation

extension String {
    var isValidURL: Bool {
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
                // it is a link, if the match covers the whole string
                return match.range.length == self.utf16.count
            } else {
                return false
            }
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func splitStringToArray() -> [String] {
        let trimmedText = String(self.filter { !" \n\t\r".contains($0) })
        var substringArray: [String] = []
        for (index, _) in trimmedText.enumerated() {
            let prefixIndex = index + 1
            let substringPrefix = String(trimmedText.prefix(prefixIndex)).lowercased()
            substringArray.append(substringPrefix)
        }
        return substringArray
    }
    
    func normalizeEmail() -> String {
        let email = self
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let removedAliases = trimmedEmail.removeAliases()
        return removedAliases.lowercased()
    }
    
    func removeAliases() -> String {
        let str = self
        // isolate what is before the @domain
        let chunks = str.split(separator: "@")
        if chunks.count > 1 {
            let email = chunks[0]
            let emailWithoutPeriods = email.replacingOccurrences(of: ".", with: "")
            // Get everything before the '+'
            let emailWithoutPlus = emailWithoutPeriods.split(separator: "+")[0]
            // put back the domain name
            return emailWithoutPlus + "@" + chunks[1]
        } else {
          return str
        }
      }
    
    static func isValidEmailAddress(emailAddress: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddress as NSString
            let results = regex.matches(in: emailAddress, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    static func isValidUsername(username: String) -> Bool {
        
        var returnValue = true
        let usernameRegEx = "^[a-zA-Z0-9_-]*$"
        
        do {
            let regex = try NSRegularExpression(pattern: usernameRegEx)
            let nsString = username as NSString
            let results = regex.matches(in: username, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
}

extension Character {
    
    //converts a character to uppercase
    func convertToUpperCase() -> Character {
        if(self.isUppercase){
            return self
        }
        return Character(self.uppercased())
    }
}

