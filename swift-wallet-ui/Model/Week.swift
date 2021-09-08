//
//  Week.swift
//  swift-wallet-ui
//
//  Created by Danh Tu on 08/09/2021.
//

import Foundation
import SwiftUI

struct Week: Identifiable {
    var id = UUID().uuidString
    var day: String
    var date: String
    var amountSpent: CGFloat
}
