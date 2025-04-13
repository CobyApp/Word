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
    var fetchByLevelAndRange: @Sendable (String, Int, Int) throws -> [Word]

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
            let descriptor = FetchDescriptor<WordModel>(
                sortBy: [SortDescriptor(\.number, order: .forward)]
            )
            let models = try modelContext.fetch(descriptor)
            print("Fetched \(models.count) WordModels")
            return models.map { $0.domain }
        },
        fetchByLevel: { level in
            @Dependency(\.databaseService.context) var context
            let modelContext = try context()
            let descriptor = FetchDescriptor<WordModel>(
                predicate: #Predicate { $0.level == level },
                sortBy: [SortDescriptor(\.number, order: .forward)]
            )
            let models = try modelContext.fetch(descriptor)
            print("Fetched \(models.count) WordModels for level: \(level)")
            return models.map { $0.domain }
        },
        fetchByLevelAndRange: { level, index, offset in
            guard index >= 0 && index < 5 else {
                throw WordError.invalidRange
            }
            let start = String(format: "%03d", index * 100 + 1 + offset)
            let end = String(format: "%03d", (index + 1) * 100)
            
            @Dependency(\.databaseService.context) var context
            let modelContext = try context()
            let descriptor = FetchDescriptor<WordModel>(
                predicate: #Predicate {
                    $0.level == level &&
                    $0.number >= start &&
                    $0.number <= end
                },
                sortBy: [SortDescriptor(\.number, order: .forward)]
            )
            let models = try modelContext.fetch(descriptor)
            print("Fetched \(models.count) WordModels for level: \(level), range: \(index) (numbers: \(start)-\(end))")
            return models.map { $0.domain }
        }
    )
}
