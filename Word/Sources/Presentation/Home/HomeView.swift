//
//  HomeView.swift
//  Word
//
//  Created by Coby on 12/12/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import SwiftUI

import CobyDS
import ComposableArchitecture

struct HomeView: View {
    
    @Bindable private var store: StoreOf<HomeStore>
    
    init(store: StoreOf<HomeStore>) {
        self.store = store
    }
    
    private let ranges: [String] = [
        "Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                leftSide: .title,
                leftTitle: "単語百先生"
            )
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(WordLevel.allCases, id: \.self) { level in
                        JLPTCardView(
                            levelName: level.title,
                            color: level.color,
                            ranges: self.ranges,
                            onRangeTap: { range in
                                self.store.send(.navigateToRangeDetail(level.rawValue, range))
                            }
                        )
                        .padding(.horizontal, BaseSize.horizantalPadding)
                    }
                }
                .padding(.vertical, BaseSize.verticalPadding)
            }
        }
        .background(Color.backgroundNormalAlternative)
    }
}
