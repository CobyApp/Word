//
//  WordLevel.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS

enum WordLevel: String, CaseIterable {
    case n1 = "n1"
    case n2 = "n2"
    case n3 = "n3"
    
    var fileName: String {
        return rawValue
    }
    
    var title: String {
        switch self {
        case .n1: return "JLPT N1"
        case .n2: return "JLPT N2"
        case .n3: return "JLPT N3"
        }
    }
    
    var color: Color {
        switch self {
        case .n1: return Color.green40
        case .n2: return Color.blue40
        case .n3: return Color.red40
        }
    }
}
