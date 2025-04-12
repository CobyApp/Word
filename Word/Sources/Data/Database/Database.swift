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

extension DependencyValues {
    var databaseService: Database {
        get { self[Database.self] }
        set { self[Database.self] = newValue }
    }
}

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

let sharedContext: ModelContext = {
    return ModelContext(sharedContainer)
}()

struct Database {
    var context: () throws -> ModelContext
}

extension Database: DependencyKey {
    public static let liveValue = Self(
        context: { sharedContext }
    )
}

extension Database: TestDependencyKey {
    public static var previewValue = Self.noop
    
    public static let testValue = Self(
        context: unimplemented("\(Self.self).context")
    )
    
    static let noop = Self(
        context: unimplemented("\(Self.self).context")
    )
}
