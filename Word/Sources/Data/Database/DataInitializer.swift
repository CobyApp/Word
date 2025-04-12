//
//  DataInitializer.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation
import SwiftData

class DataInitializer {
    static func initializeDataIfNeeded(context: ModelContext) {
        print("Starting data initialization...")
        
        // 기존 데이터 삭제
        let descriptor = FetchDescriptor<WordModel>()
        if let existingWords = try? context.fetch(descriptor) {
            for word in existingWords {
                context.delete(word)
            }
            try? context.save()
            print("Deleted existing words")
        }
        
        for level in WordLevel.allCases {
            print("Processing level: \(level.rawValue)")
            guard let jsonData = loadJSONData(for: level) else {
                print("Failed to load JSON for level: \(level.rawValue)")
                continue
            }
            
            do {
                let decoder = JSONDecoder()
                let words = try decoder.decode([WordDTO].self, from: jsonData)
                print("Decoded \(words.count) words for level: \(level.rawValue)")
                
                for wordDTO in words {
                    let word = WordModel(
                        id: UUID(),
                        number: wordDTO.id,
                        kanji: wordDTO.kanji,
                        hiragana: wordDTO.hiragana,
                        meaning: wordDTO.meaning,
                        level: level.rawValue
                    )
                    context.insert(word)
                }
                
                try context.save()
                print("Successfully saved \(words.count) words for level: \(level.rawValue)")
            } catch {
                print("Error decoding JSON for level \(level.rawValue): \(error)")
            }
        }
        
        print("Data initialization completed")
    }
    
    private static func loadJSONData(for level: WordLevel) -> Data? {
        guard let fileURL = Bundle.main.url(forResource: level.fileName, withExtension: "json") else {
            print("JSON file for \(level.fileName) not found")
            return nil
        }
        print("Found JSON file for \(level.fileName) at: \(fileURL)")
        return try? Data(contentsOf: fileURL)
    }
}
