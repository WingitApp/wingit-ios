//
//  StringExtensions.swift
//  wingit4
//
//  Created by (310) 748-1434 on 9/16/21.
//

import Foundation

extension String {
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
    
    private func regExprOfDetectingStringsBetween(str1: String, str2: String) -> String {
            return "(?:\(str1))(.*?)(?:\(str2))"
        }
        
    func replacingOccurrences(from subString1: String, to subString2: String, with replacement: String) -> String {
        let regExpr = regExprOfDetectingStringsBetween(str1: subString1, str2: subString2)
        return replacingOccurrences(of: regExpr, with: replacement, options: .regularExpression)
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
    
    func removePlusAlias() -> String {
        let str = self
        let chunks = str.split(separator: "+")
        if chunks.count > 1 {
            return String(chunks[0])
        } else {
          return str
        }
      }
    
    static func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
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
