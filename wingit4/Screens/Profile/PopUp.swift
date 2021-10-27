//
//  PopUp.swift
//  wingit4
//
//  Created by Amy Chun on 9/28/21.
//

import SwiftUI

struct Popup<T: View>: ViewModifier {
    let popup: T
    let isPresented: Bool
    let alignment: Alignment
    let direction: Direction

    // 1.
    init(isPresented: Bool, alignment: Alignment, direction: Direction, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        self.direction = direction
        popup = content()
    }

    // 2.
    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    // 3.
    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .animation(.spring()) // 1.
                    .transition(.offset(x: 0, y: direction.offset(popupFrame: geometry.frame(in: .global))))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
        }
    }
}

private extension GeometryProxy {
    var belowScreenEdge: CGFloat {
        UIScreen.main.bounds.height - frame(in: .global).minY
    }
}
extension View {
    func popup<T: View>(
        isPresented: Bool,
        alignment: Alignment = .center,
        direction: Popup<T>.Direction = .bottom,
        @ViewBuilder content: () -> T
    ) -> some View {
        return modifier(Popup(isPresented: isPresented, alignment: alignment, direction: direction, content: content))
    }
}
//
//struct Popup1_Previews: PreviewProvider {
//    static var previews: some View {
//
//        Color.clear
//            .modifier(Popup(isPresented: true,
//                            alignment: .topTrailing,
//                            content: { Color.yellow.frame(width: 100, height: 100) }))
//            .modifier(Popup(isPresented: true,
//                            alignment: .center,
//                                        content: { Color.orange.frame(width: 100, height: 100) }))
//            .modifier(Popup(isPresented: true,
//                                        alignment: .bottomLeading,
//                                        content: { Color.blue.frame(width: 100, height: 100) }))
//            .previewDevice("iPod touch")
//    }
//}


struct Popup3_Previews: PreviewProvider {

    static var previews: some View {
        Preview()
            .previewDevice("iPod touch")
    }

    // Helper view that shows a popup
    struct Preview: View {
        @State var isPresented = false

        var body: some View {
            ZStack {
                Color.clear
                VStack {
                    Button("Toggle", action: { isPresented.toggle() })
                    Spacer()
                }
            }
            .modifier(Popup(isPresented: isPresented,
                            alignment: .center,
                            direction: .top,
                            content: { Color.yellow.frame(width: 100, height: 100) }))
        }
    }
}

extension Popup {
    enum Direction {
        case top, bottom

        func offset(popupFrame: CGRect) -> CGFloat {
            switch self {
            case .top:
                let aboveScreenEdge = -popupFrame.maxY
                return aboveScreenEdge
            case .bottom:
                let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
                return belowScreenEdge
            
            }
        }
    }
}

