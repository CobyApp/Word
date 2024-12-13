//
//  WordDTO.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation

struct WordDTO: Codable {
    let id: String
    let kanji: String
    let hiragana: String
    let meaning: String
}
