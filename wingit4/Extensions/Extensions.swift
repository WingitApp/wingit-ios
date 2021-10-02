//
//  Extensions.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI

extension UIApplication {

 static var appVersion: String? {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
 }

}

public enum Model : String {

    case simulator     = "simulator",

    iPod1              = "iPod 1",
    iPod2              = "iPod 2",
    iPod3              = "iPod 3",
    iPod4              = "iPod 4",
    iPod5              = "iPod 5",

    iPad2              = "iPad 2",
    iPad3              = "iPad 3",
    iPad4              = "iPad 4",
    iPadAir            = "iPad Air ",
    iPadAir2           = "iPad Air 2",
    iPadAir3           = "iPad Air 3",
    iPad5              = "iPad 5",
    iPad6              = "iPad 6",
    iPad7              = "iPad 7",

    iPadMini           = "iPad Mini",
    iPadMini2          = "iPad Mini 2",
    iPadMini3          = "iPad Mini 3",
    iPadMini4          = "iPad Mini 4",
    iPadMini5          = "iPad Mini 5",

    iPadPro9_7         = "iPad Pro 9.7\"",
    iPadPro10_5        = "iPad Pro 10.5\"",
    iPadPro11          = "iPad Pro 11\"",
    iPadPro12_9        = "iPad Pro 12.9\"",
    iPadPro2_12_9      = "iPad Pro 2 12.9\"",
    iPadPro3_12_9      = "iPad Pro 3 12.9\"",

    iPhone4            = "iPhone 4",
    iPhone4S           = "iPhone 4S",
    iPhone5            = "iPhone 5",
    iPhone5S           = "iPhone 5S",
    iPhone5C           = "iPhone 5C",
    iPhone6            = "iPhone 6",
    iPhone6Plus        = "iPhone 6 Plus",
    iPhone6S           = "iPhone 6S",
    iPhone6SPlus       = "iPhone 6S Plus",
    iPhoneSE           = "iPhone SE",
    iPhone7            = "iPhone 7",
    iPhone7Plus        = "iPhone 7 Plus",
    iPhone8            = "iPhone 8",
    iPhone8Plus        = "iPhone 8 Plus",
    iPhoneX            = "iPhone X",
    iPhoneXS           = "iPhone XS",
    iPhoneXSMax        = "iPhone XS Max",
    iPhoneXR           = "iPhone XR",
    iPhone11           = "iPhone 11",
    iPhone11Pro        = "iPhone 11 Pro",
    iPhone11ProMax     = "iPhone 11 Pro Max",

    AppleTV            = "Apple TV",
    AppleTV_4K         = "Apple TV 4K",
    unrecognized       = "?unrecognized?"
}

public extension UIDevice {

    var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }

        let modelMap : [String: Model] = [
            "i386"      : .simulator,
            "x86_64"    : .simulator,

            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,

            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPad6,11"  : .iPad5,
            "iPad6,12"  : .iPad5,
            "iPad7,5"   : .iPad6,
            "iPad7,6"   : .iPad6,
            "iPad7,11"  : .iPad7,
            "iPad7,12"  : .iPad7,

            "iPad2,5"   : .iPadMini,
            "iPad2,6"   : .iPadMini,
            "iPad2,7"   : .iPadMini,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad5,1"   : .iPadMini4,
            "iPad5,2"   : .iPadMini4,
            "iPad11,1"  : .iPadMini5,
            "iPad11,2"  : .iPadMini5,

            "iPad6,3"   : .iPadPro9_7,
            "iPad6,4"   : .iPadPro9_7,
            "iPad7,3"   : .iPadPro10_5,
            "iPad7,4"   : .iPadPro10_5,
            "iPad6,7"   : .iPadPro12_9,
            "iPad6,8"   : .iPadPro12_9,
            "iPad7,1"   : .iPadPro2_12_9,
            "iPad7,2"   : .iPadPro2_12_9,
            "iPad8,1"   : .iPadPro11,
            "iPad8,2"   : .iPadPro11,
            "iPad8,3"   : .iPadPro11,
            "iPad8,4"   : .iPadPro11,
            "iPad8,5"   : .iPadPro3_12_9,
            "iPad8,6"   : .iPadPro3_12_9,
            "iPad8,7"   : .iPadPro3_12_9,
            "iPad8,8"   : .iPadPro3_12_9,

            "iPad4,1"   : .iPadAir,
            "iPad4,2"   : .iPadAir,
            "iPad4,3"   : .iPadAir,
            "iPad5,3"   : .iPadAir2,
            "iPad5,4"   : .iPadAir2,
            "iPad11,3"  : .iPadAir3,
            "iPad11,4"  : .iPadAir3,

            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPhone7,1" : .iPhone6Plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6SPlus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7Plus,
            "iPhone9,4" : .iPhone7Plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8Plus,
            "iPhone10,5" : .iPhone8Plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            "iPhone12,1" : .iPhone11,
            "iPhone12,3" : .iPhone11Pro,
            "iPhone12,5" : .iPhone11ProMax,

            "AppleTV5,3" : .AppleTV,
            "AppleTV6,2" : .AppleTV_4K
        ]

        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                        return simModel
                    }
                }
            }
            return model
        }
        return Model.unrecognized
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
  
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
       clipShape( RoundedCorner(radius: radius, corners: corners) )
   }
    
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
            if condition() {
                transform(self)
            } else {
                self
            }
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

func timeAgoSinceDate(_ secondsSince1970: TimeInterval, currentDate:Date, numericDates:Bool) -> String {
    let calendar = Calendar.current
    let now = currentDate
    let date = Date(timeIntervalSinceReferenceDate: secondsSince1970)
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
  
  static let lightGray: Color = Color(red: 238 / 255, green: 241 / 255, blue: 243 / 255)
  static let wingitBlue: Color = Color(red: 33 / 255, green: 113 / 255, blue: 150 / 255)
  
  static let backgroundGray: Color = Color(red: 245 / 255, green: 247 / 255, blue: 248 / 255)
  
  static let backgroundBlueGray: Color = Color(red: 240 / 255, green: 247 / 255, blue: 251 / 255)
  
  static let borderGray: Color = Color(red: 216 / 255, green: 216 / 255, blue: 217 / 255)
    
  static let notificationBackground: Color = Color(red: 224 / 255, green: 237 / 255, blue: 236 / 255)
  
  
  // TAG Color
  static let uiviolet: Color = Color(red: 69 / 255, green: 73 / 255, blue: 255 / 255)
  static let uilightViolet: Color = Color(red: 234 / 255, green: 235 / 255, blue: 254 / 255)
  
  static let uiblue: Color = Color(red: 118 / 255, green: 153 / 255, blue: 173 / 255)
  static let uilightBlue: Color = Color(red: 240 / 255, green: 251 / 255, blue: 255 / 255)
  
  static let uigreen: Color = Color(red: 102 / 255, green: 137 / 255, blue: 74 / 255)
  static let uilightGreen: Color = Color(red: 241 / 255, green: 255 / 255, blue: 230 / 255)
  
  static let uilightOrange: Color = Color(red: 255 / 255, green: 245 / 255, blue: 230 / 255)
  static let uiorange: Color = Color(red: 255 / 255, green: 179 / 255, blue: 71 / 255)
  
  // complete status
  static let statusGreen: Color = Color(red: 33 / 255, green: 229 / 255, blue: 192 / 255)
  
  // social media icon
  static let fbBlueBackground: Color = Color(red: 229 / 255, green: 239 / 255, blue: 254 / 255)
  static let twitterBlueBackground: Color = Color(red: 229 / 255, green: 245 / 255, blue: 254 / 255)
  static let redditRedBackground: Color = Color(red: 255 / 255, green: 233 / 255, blue: 226 / 255)
  static let linkedinBlueBackground: Color = Color(red: 226 / 255, green: 242 / 255, blue: 255 / 255)
  static let spotifyGreenBackground: Color = Color(red: 240 / 255, green: 246 / 255, blue: 231 / 255)

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

extension Color {
  public func lighter(by amount: CGFloat = 0.2) -> Self { Self(UIColor(self).lighter(by: amount)!) }
  public func darker(by amount: CGFloat = 0.2) -> Self { Self(UIColor(self).darker(by: amount)!) }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
  

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
  
  func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
      var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
      if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
        if b < 1.0 {
          let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
          return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
        } else {
          let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
          return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
        }
      }
      return self
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension AnyTransition {
  
    static var enterLeftAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
  
    static var enterRightAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
  
    static var enterTopAndFade: AnyTransition {
      let insertion = AnyTransition.move(edge: .top)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
  
    static var enterBottomAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
  
    static var enterAndExitLeft: AnyTransition {
      let insertion = AnyTransition.move(edge: .leading)
//          .combined(with: .opacity)
      let removal = AnyTransition.move(edge: .leading)
          .combined(with: .opacity)
      return .asymmetric(insertion: insertion, removal: removal)
    }
  
    static var enterAndExitRight: AnyTransition {
      let insertion = AnyTransition.move(edge: .trailing)
//          .combined(with: .opacity)
      let removal = AnyTransition.move(edge: .trailing)
          .combined(with: .opacity)
      return .asymmetric(insertion: insertion, removal: removal)
    }
  
    
}
