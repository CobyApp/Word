//
//  Database.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation
import SwiftData
import Dependencies

// MARK: - Dependency 등록
extension DependencyValues {
    var databaseService: Database {
        get { self[Database.self] }
        set { self[Database.self] = newValue }
    }
}

// MARK: - 공유 ModelContainer (mutable 아님, 공유 안전)
fileprivate let sharedContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: WordModel.self)
        let context = ModelContext(container)
        DataInitializer.initializeDataIfNeeded(context: context)
        return container
    } catch {
        fatalError("Failed to create shared container: \(error)")
    }
}()

// MARK: - Database 구조체
struct Database: @unchecked Sendable {
    var context: @Sendable () throws -> ModelContext
}

// MARK: - 실제 런타임 값
extension Database: DependencyKey {
    static let liveValue = Self(
        context: {
            return ModelContext(sharedContainer)
        }
    )
}

// MARK: - 테스트용 값
extension Database: TestDependencyKey {
    static let previewValue = Self.noop

    static let testValue = Self(
        context: unimplemented("\(Self.self).context")
    )

    static let noop = Self(
        context: unimplemented("\(Self.self).context")
    )
}
