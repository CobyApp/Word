//
//  Color+Extensions.swift
//  Word
//
//  Created by Coby on 12/12/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS

extension Color {
    static var mocha: Color = Color(hex: "#A47864")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
