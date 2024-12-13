//
//  Word.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation
import SwiftData

@Model
class Word: Identifiable {
    @Attribute(.unique) var id: UUID
    var number: String
    var kanji: String
    var hiragana: String
    var meaning: String
    var level: String
    
    init(
        number: String,
        kanji: String,
        hiragana: String,
        meaning: String,
        level: String
    ) {
        self.id = UUID()
        self.number = number
        self.kanji = kanji
        self.hiragana = hiragana
        self.meaning = meaning
        self.level = level
    }
}
