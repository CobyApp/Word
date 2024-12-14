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
        @Presents var final: FinalStore.State?
        
        let level: String
        let range: Int
        var words: [Word] = []
        var currentWordIndex: Int = 0
        var forgottenWordCounts: [UUID: Int] = [:] // 단어별 '모르겠음' 선택 횟수
        var rememberedWords: Set<UUID> = [] // '외웠음' 선택된 단어 ID 집합
        
        var currentWord: Word? {
            guard !words.isEmpty, currentWordIndex >= 0, currentWordIndex < words.count else {
                return nil
            }
            return words[currentWordIndex]
        }
        
        init(level: String, range: Int) {
            self.level = level
            self.range = range
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case final(PresentationAction<FinalStore.Action>)
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
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .final:
                return .none
                
            case .navigateToFinal(let words):
                state.final = FinalStore.State(words: words)
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
                    // '모르겠음' 카운트 제거
                    state.forgottenWordCounts[currentWord.id] = nil
                }
                return self.moveToNextWord(state: &state)
                
            case .dismiss:
                return .run { _ in await self.dismiss() }
            }
        }
        .ifLet(\.$final, action: \.final) {
            FinalStore()
        }
    }
    
    private func moveToNextWord(state: inout State) -> Effect<Action> {
        // 다음 단어로 이동
        state.currentWordIndex += 1
        
        // 모든 단어가 끝난 경우
        if state.currentWordIndex >= state.words.count {
            if state.forgottenWordCounts.isEmpty {
                // '모두 외웠음' 상태 -> 상위 10개의 '모르겠음' 단어 추출 및 화면 전환
                let mostForgottenWords = state.forgottenWordCounts
                    .sorted { $0.value > $1.value }
                    .prefix(10)
                    .compactMap { id, _ in state.words.first { $0.id == id } }
                
                return .send(.navigateToFinal(mostForgottenWords))
            } else {
                // 사이클 반복, 잊은 단어만 다시 학습
                state.words = state.words.filter { state.forgottenWordCounts[$0.id, default: 0] > 0 }
                state.currentWordIndex = 0
                print("Restarting cycle with forgotten words.")
            }
        }
        
        return .none
    }
}
