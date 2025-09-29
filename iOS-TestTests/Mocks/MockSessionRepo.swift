//
//  MockSessionRepo.swift
//  iOS-TestTests
//
//  Created by Mari Budko on 29.09.2025.
//

import Foundation
@testable import iOS_Test

final class MockSessionRepo: SessionRepositoryProtocol {
    var completedCount: Int
    var sessions: [SessionModel] = []
    
    init(completedCount: Int) {
        self.completedCount = completedCount
    }
    
    func add(session: iOS_Test.SessionModel) {
        
    }
    
    func getAllCompleted() -> [iOS_Test.SessionModel] {
        let completed = sessions
            .filter{ $0.sessionEnd != nil }
        return completed
    }
    
    func getLatest() -> iOS_Test.SessionModel? {
        return nil
    }
    
    func update(session: iOS_Test.SessionModel) {
        
    }
    
    func removeAllCompleted() {
        
    }
    
    func set2CompletedSessions() {
        self.sessions.removeAll()
        sessions.append(SessionModel(sessionId: UUID(), sessionStart: Date(timeIntervalSince1970: 1_759_100_000), sessionEnd: Date(timeIntervalSince1970: 1_759_110_000)))
        sessions.append(SessionModel(sessionId: UUID(), sessionStart: Date(timeIntervalSince1970: 1_759_111_000), sessionEnd: Date(timeIntervalSince1970: 1_759_120_000)))
        sessions.append(SessionModel(sessionId: UUID(), sessionStart: Date(timeIntervalSince1970: 1_759_111_000), sessionEnd: nil))
    }
}
