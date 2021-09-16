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
}
