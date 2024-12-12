//
//  RangeDetailView.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS
import ComposableArchitecture

struct RangeDetailView: View {
    
    @Bindable private var store: StoreOf<RangeDetailStore>
    
    init(store: StoreOf<RangeDetailStore>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            Text("\(self.store.level) - \(self.store.range)")
                .font(.system(size: 32, weight: .bold, design: .default))
                .padding(.top, 40)
            Spacer()
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
    }
}
