//
//  WordDatabase.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation
import SwiftData
import Dependencies

extension DependencyValues {
    var wordData: WordDatabase {
        get { self[WordDatabase.self] }
        set { self[WordDatabase.self] = newValue }
    }
}

struct WordDatabase {
    var fetchAll: @Sendable () throws -> [Word]
    var fetchByLevel: @Sendable (String) throws -> [Word]
    var fetchByLevelAndRange: @Sendable (String, Int) throws -> [Word]

    enum WordError: Error {
        case fetchError
        case invalidRange
    }
}

extension WordDatabase: DependencyKey {
    public static let liveValue = Self(
        fetchAll: {
            @Dependency(\.databaseService.context) var context
            let modelContext = try context()
            let descriptor = FetchDescriptor<Word>(sortBy: [SortDescriptor(\.id)])
            return try modelContext.fetch(descriptor)
        },
        fetchByLevel: { level in
            @Dependency(\.databaseService.context) var context
            let modelContext = try context()
            let descriptor = FetchDescriptor<Word>(predicate: #Predicate { $0.level == level })
            return try modelContext.fetch(descriptor)
        },
        fetchByLevelAndRange: { level, index in
            guard index >= 0 && index < 5 else {
                throw WordError.invalidRange
            }
            let start = String(format: "%03d", index * 100 + 1)
            let end = String(format: "%03d", (index + 1) * 100)
            
            @Dependency(\.databaseService.context) var context
            let modelContext = try context()
            let descriptor = FetchDescriptor<Word>(predicate: #Predicate {
                $0.level == level &&
                $0.id >= start &&
                $0.id <= end
            })
            return try modelContext.fetch(descriptor)
        }
    )
}
