//
//  iOS_TestTests.swift
//  iOS-TestTests
//
//  Created by Mari Budko on 29.09.2025.
//

import Foundation
import Testing
@testable import iOS_Test

struct ReviewRequestServiceTests {
    
    @Test func doesNotTriggerWithoutRequirements() {
        let mockSessionRepo = MockSessionRepo(completedCount: 1)
        let mockLifecycleRepo = MockLifeCycleRepo(total: 5*60, lastFg: nil)
        let spyReviewRepo = SpyReviewRepo()
        let now = Date()
        
        let reviewRequestService = ReviewRequestService(
            sessionRepo: mockSessionRepo,
            lifeCycleRepo: mockLifecycleRepo,
            reviewRepo: spyReviewRepo,
            dateProvider: { now }
        )
        
        reviewRequestService.evaluateAndRequestIfNeeded(on: nil)
        
        #expect(spyReviewRepo.lastSetDate == nil)
    }
    
    @Test func triggersWhenAllConditionsSatisfied() {
        let mockSessionRepo = MockSessionRepo(completedCount: 2)
        let mockLifecycleRepo = MockLifeCycleRepo(total: 10 * 60, lastFg: nil)
        let spyReviewRepo = SpyReviewRepo()
        let now = Date()
        
        // adding mock sessions list
        mockSessionRepo.set2CompletedSessions()
        
        let reviewRequestService = ReviewRequestService(
            sessionRepo: mockSessionRepo,
            lifeCycleRepo: mockLifecycleRepo,
            reviewRepo: spyReviewRepo,
        dateProvider: { now })
        
        reviewRequestService.evaluateAndRequestIfNeeded(on: nil)
        
        #expect(spyReviewRepo.lastSetDate == now)
    }
    
}
