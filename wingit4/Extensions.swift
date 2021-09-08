//
//  Extensions.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import Foundation
import SwiftUI

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
  
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension Date {
    static func iso8601ShortDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

func timeAgoSinceDate(_ date:Date, currentDate:Date, numericDates:Bool) -> String {
    let calendar = Calendar.current
    let now = currentDate
    let earliest = (now as NSDate).earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){ return "1 year ago"
        } else { return "Last year" }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){ return "1 month ago"
        } else { return "Last month" }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){ return "1 week ago"
        } else { return "Last week" }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){ return "1 day ago"
        } else { return "Yesterday" }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){ return "1 hour ago"
        } else { return "An hour ago" }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){ return "1 minute ago"
        } else { return "A minute ago" }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else { return "Just now" }
}

func printDecodingError(error: Error) {
    switch error {
        case DecodingError.typeMismatch(let type, let context):
          print("type:  \(type)")
          print("\(error.localizedDescription): \(context.debugDescription)")
        case DecodingError.valueNotFound(let type, let context):
          print("type: \(type)")
          print("\(error.localizedDescription): \(context.debugDescription)")
        case DecodingError.keyNotFound(let key, let context):
          print("key: \(key)")
          print("\(error.localizedDescription): \(context.debugDescription)")
        case DecodingError.dataCorrupted(let key):
          print("key: \(key)")
          print("\(error.localizedDescription): \(key)")
        default:
          print("Error decoding document: \(error.localizedDescription)")
        }
}

extension Array {
       func splited(into size:Int) -> [[Element]] {
         
         var splittedArray = [[Element]]()
         if self.count >= size {
                 
             for index in 0...self.count {
                if index % size == 0 && index != 0 {
                    splittedArray.append(Array(self[(index - size)..<index]))
                } else if(index == self.count) {
                    splittedArray.append(Array(self[index - 1..<index]))
                }
             }
         } else {
             splittedArray.append(Array(self[0..<self.count]))
         }
         return splittedArray
     }
}

extension String {
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

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Decodable {
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

extension Color {
    
    static let instagram: [Color] = [
        Color(red: 64 / 255, green: 93 / 255, blue: 230 / 255),
        Color(red: 88 / 255, green: 81 / 255, blue: 219 / 255),
        Color(red: 131 / 255, green: 58 / 255, blue: 180 / 255),
        Color(red: 193 / 255, green: 53 / 255, blue: 132 / 255),
        Color(red: 225 / 255, green: 48 / 255, blue: 108 / 255),
        Color(red: 253 / 255, green: 29 / 255, blue: 29 / 255),
        Color(red: 245 / 255, green: 96 / 255, blue: 64 / 255),
        Color(red: 247 / 255, green: 119 / 255, blue: 55 / 255),
        Color(red: 252 / 255, green: 175 / 255, blue: 69 / 255),
        Color(red: 255 / 255, green: 220 / 255, blue: 128 / 255),
        Color(red: 64 / 255, green: 93 / 255, blue: 230 / 255)
    ]
  
//  static let cardBlue: Color = Color(red: 109 / 255, green: 155 / 255, blue: 230 / 255)
//  static let cardOrange: Color = Color(red: 227 / 255, green: 147 / 255, blue: 80 / 255)
//  static let cardRed: Color = Color(red: 221 / 255, green: 79 / 255, blue: 110 / 255)
//  static let cardPurp: Color = Color(red: 156 / 255, green: 108 / 255, blue: 231 / 255)
//  static let cardGreen: Color = Color(red: 91 / 255, green: 211 / 255, blue: 177 / 255)
//
  static let charcoal: Color = Color(red: 37 / 255, green: 40 / 255, blue: 42 / 255)
  
  static let downeyGreen: Color = Color(red: 109 / 255, green: 204 / 255, blue: 176 / 255)
  static let mintGreen: Color = Color(red: 241 / 255, green: 255 / 255, blue: 250 / 255)
  static let carnationRed: Color = Color(red: 253 / 255, green: 84 / 255, blue: 89 / 255)
  static let apricotWhite: Color = Color(red: 248 / 255, green: 241 / 255, blue: 228 / 255)
  static let tolopeaViolet: Color = Color(red: 35 / 255, green: 30 / 255, blue: 50 / 255)

  
}
// bottom only corners....

struct RoundedShape : Shape {
    
    // for resuable.....
    var corners : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 45, height: 45))
        
        return Path(path.cgPath)
    }
}

extension Int {

    func formatUsingAbbrevation () -> String {
        let numFormatter = NumberFormatter()

        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (100_000_000.0, 1_000_000_000.0, "B")]
                                           // you can add more !

        let startValue = Double (abs(self))
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()

        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1

      return numFormatter.string(from: NSNumber (value:value))!
    }

}
