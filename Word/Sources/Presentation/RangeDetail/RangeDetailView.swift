//
//  RangeDetailView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS

struct RangeDetailView: View {
    let level: String
    let range: String
    
    var body: some View {
        VStack {
            Text("\(level) - \(range)")
                .font(.system(size: 32, weight: .bold, design: .default))
                .padding(.top, 40)
            Spacer()
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
    }
}
