//
//  QuizStore.swift
//  Word
//
//  Created by Coby on 12/13/24.
//  Copyright © 2024 Coby. All rights reserved.
//

import Foundation

import ComposableArchitecture

@Reducer
struct QuizStore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        let level: String
        let range: Int
        var words: [Word] = []
        var initialWordCount: Int = 0 // 초기 단어 수 저장
        var currentWordIndex: Int = 0
        var forgottenWordCounts: [UUID: Int] = [:] // 단어별 '모르겠음' 선택 횟수
        var rememberedWords: Set<UUID> = [] // '외웠음' 선택된 단어 ID 집합
        
        // 현재 단어
        var currentWord: Word? {
            guard !words.isEmpty, currentWordIndex >= 0, currentWordIndex < words.count else {
                return nil
            }
            return words[currentWordIndex]
        }
        
        // 진행 상황 비율 (0.0 ~ 1.0)
        var progress: Double {
            guard initialWordCount > 0 else { return 0.0 }
            let completedWords = rememberedWords.count
            return Double(completedWords) / Double(initialWordCount)
        }
        
        init(level: String, range: Int) {
            self.level = level
            self.range = range
        }
    }
    
    enum Action: Equatable {
        case navigateToFinal([Word])
        case fetchByLevelAndRange(String, Int)
        case fetchByLevelAndRangeResponse(TaskResult<[Word]>)
        case didNotRemember
        case didRemember
        case dismiss
    }
    
    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.wordData) private var wordContext
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .navigateToFinal:
                return .none
                
            case .fetchByLevelAndRange(let level, let range):
                return .run { send in
                    let result = await TaskResult {
                        try self.wordContext.fetchByLevelAndRange(level, range)
                    }
                    await send(.fetchByLevelAndRangeResponse(result))
                }
                
            case let .fetchByLevelAndRangeResponse(.success(words)):
                state.words = words
                state.initialWordCount = words.count // 초기 단어 수 저장
                state.currentWordIndex = 0
                state.forgottenWordCounts = [:]
                state.rememberedWords = []
                return .none
                
            case let .fetchByLevelAndRangeResponse(.failure(error)):
                print("Error fetching words: \(error.localizedDescription)")
                return .none
                
            case .didNotRemember:
                if let currentWord = state.currentWord {
                    // '모르겠음' 선택된 단어의 선택 횟수 증가
                    state.forgottenWordCounts[currentWord.id, default: 0] += 1
                }
                return self.moveToNextWord(state: &state)
                
            case .didRemember:
                if let currentWord = state.currentWord {
                    // '외웠음' 선택된 단어를 기억된 집합에 추가
                    state.rememberedWords.insert(currentWord.id)
                }
                return self.moveToNextWord(state: &state)
                
            case .dismiss:
                return .run { _ in await self.dismiss() }
            }
        }
    }
    
    private func moveToNextWord(state: inout State) -> Effect<Action> {
        // 현재 단어 인덱스를 증가
        state.currentWordIndex += 1

        // 모든 단어가 끝난 경우
        if state.currentWordIndex >= state.words.count {
            if state.rememberedWords.count >= state.words.count - 1 {
                // '모르겠음' 단어가 없으면 가장 많이 몰랐던 단어 상위 10개 추출
                let mostForgottenWords = state.forgottenWordCounts
                    .sorted { $0.value > $1.value }
                    .prefix(10)
                    .compactMap { id, _ in state.words.first(where: { $0.id == id }) }

                return .send(.navigateToFinal(mostForgottenWords))
            } else {
                // 잊은 단어로 사이클 반복
                state.words = state.words.filter {
                    !state.rememberedWords.contains($0.id)
                }
                state.currentWordIndex = 0
            }
        }

        return .none
    }
}
