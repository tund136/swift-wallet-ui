//
//  CustomShape.swift
//  swift-wallet-ui
//
//  Created by Danh Tu on 08/09/2021.
//

import SwiftUI

struct CustomShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let bath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(bath.cgPath)
    }
}

