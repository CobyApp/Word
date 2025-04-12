import Foundation
import SwiftData

@Model
class WordModel {
    @Attribute(.unique) var id: UUID
    var number: String
    var kanji: String
    var hiragana: String
    var meaning: String
    var level: String
    
    init(
        id: UUID,
        number: String,
        kanji: String,
        hiragana: String,
        meaning: String,
        level: String
    ) {
        self.id = id
        self.number = number
        self.kanji = kanji
        self.hiragana = hiragana
        self.meaning = meaning
        self.level = level
    }
    
    var domain: Word {
        Word(
            id: id,
            number: number,
            kanji: kanji,
            hiragana: hiragana,
            meaning: meaning,
            level: level
        )
    }
} 