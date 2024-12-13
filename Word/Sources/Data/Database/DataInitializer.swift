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
        let userDefaultsKey = "isDataInitialized"
        
        // 이미 데이터가 초기화된 경우 실행하지 않음
        if UserDefaults.standard.bool(forKey: userDefaultsKey) {
            return
        }
        
        for level in WordLevel.allCases {
            guard let jsonData = loadJSONData(for: level) else {
                print("Failed to load JSON for level: \(level)")
                continue
            }
            
            do {
                let decoder = JSONDecoder()
                let words = try decoder.decode([WordDTO].self, from: jsonData)
                
                for wordDTO in words {
                    let word = Word(
                        id: wordDTO.id,
                        kanji: wordDTO.kanji,
                        hiragana: wordDTO.hiragana,
                        meaning: wordDTO.meaning,
                        level: level.rawValue
                    )
                    context.insert(word)
                }
            } catch {
                print("Error decoding JSON for level \(level): \(error)")
            }
        }
        
        // UserDefaults에 초기화 상태 저장
        UserDefaults.standard.set(true, forKey: userDefaultsKey)
        print("Data successfully initialized")
    }
    
    // JSON 파일 로드 함수
    private static func loadJSONData(for level: WordLevel) -> Data? {
        guard let fileURL = Bundle.main.url(forResource: level.fileName, withExtension: "json") else {
            print("JSON file for \(level.fileName) not found")
            return nil
        }
        
        return try? Data(contentsOf: fileURL)
    }
}
