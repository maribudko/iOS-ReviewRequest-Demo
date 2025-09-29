//
//  CoreDataSessionRepositoryTests.swift
//  iOS-TestTests
//
//  Created by Mari Budko on 29.09.2025.
//

import Testing
import CoreData
@testable import iOS_Test

@MainActor
struct CoreDataSessionRepositoryTests {
    
    let ctx: NSManagedObjectContext
    let repo: CoreDataSessionRepository
    
    init() {
        ctx = TestCoreData.makeInMemoryContext()
        repo = CoreDataSessionRepository(context: ctx)
    }
    
    @Test func addAndGetLatest() {
        let start = Date(timeIntervalSince1970: 1_700_000_000)
        let s1 = SessionModel(sessionId: UUID(), sessionStart: start, sessionEnd: nil)
        let s2 = SessionModel(sessionId: UUID(), sessionStart: start.addingTimeInterval(120), sessionEnd: nil)
        
        repo.add(session: s1)
        repo.add(session: s2)
        
        let latest = repo.getLatest()
        #expect(latest?.sessionId == s2.sessionId)
        #expect(latest?.sessionStart == s2.sessionStart)
    }
    
    @Test func getAllCompleted() {
        let s1 = SessionModel(
            sessionId: UUID(),
            sessionStart: Date(),
            sessionEnd: Date()
        )
        let s2 = SessionModel(
            sessionId: UUID(),
            sessionStart: Date().addingTimeInterval(10),
            sessionEnd: Date().addingTimeInterval(20)
        )
        let s3 = SessionModel(
            sessionId: UUID(),
            sessionStart: Date().addingTimeInterval(30),
            sessionEnd: nil
        )
        
        repo.add(session: s1)
        repo.add(session: s2)
        repo.add(session: s3)
        
        let completed = repo.getAllCompleted()
        #expect(completed.count == 2)
        #expect(completed.first?.sessionId == s1.sessionId)
    }
    
    @Test func updateSession() {
        let id = UUID()
        let start = Date()
        let initial = SessionModel(
            sessionId: id,
            sessionStart: start,
            sessionEnd: nil
        )
        repo.add(session: initial)
        
        let latestBeforeUpdate = repo.getLatest()
        #expect(latestBeforeUpdate?.sessionId == id)
        #expect(latestBeforeUpdate?.sessionEnd == nil)
        
        let end = start.addingTimeInterval(600)
        let updated = SessionModel(sessionId: id, sessionStart: start, sessionEnd: end)
        repo.update(session: updated)
        
        let latestAfterUpdate = repo.getLatest()
        #expect(latestAfterUpdate?.sessionId == id)
        #expect(latestAfterUpdate?.sessionEnd == end)
    }
    
    @Test func removeAllNotActiveSessions() {
        let s1 = SessionModel(
            sessionId: UUID(),
            sessionStart: Date(),
            sessionEnd: Date()
        )
        let s2 = SessionModel(
            sessionId: UUID(),
            sessionStart: Date().addingTimeInterval(10),
            sessionEnd: Date().addingTimeInterval(20)
        )
        let s3 = SessionModel(
            sessionId: UUID(),
            sessionStart: Date().addingTimeInterval(30),
            sessionEnd: nil
        )
        
        repo.add(session: s1)
        repo.add(session: s2)
        repo.add(session: s3)
        
        let completed = repo.getAllCompleted()
        #expect(completed.count == 2)
        
        repo.removeAllCompleted()
        let completedAfterRemove = repo.getAllCompleted()
        #expect(completedAfterRemove.isEmpty)
    }
}
