//
//  RoundedCornerExtension.swift
//  ChatApp
//
//  Created by k2 tam on 20/08/2022.
//

import Foundation
import SwiftUI

//https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui
extension View{
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View{
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
struct RoundedCorner: Shape{
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
