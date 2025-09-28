//
//  SessionTrackerService.swift
//  iOS-Test
//
//  Created by Mari Budko on 26.09.2025.
//

import Foundation

final class SessionTrackerService: SessionTrackerServiceProtocol {
    private let sessionRepo: SessionRepositoryProtocol
    private let userDefaultsRepo: AppLifecycleRepositoryProtocol
    
    private let hour: TimeInterval = 60 * 60
    
    init(sessionRepo: SessionRepositoryProtocol, userDefaultsRepo: AppLifecycleRepositoryProtocol) {
        self.sessionRepo = sessionRepo
        self.userDefaultsRepo = userDefaultsRepo
    }
    
    public func willEnterForeground() {
        userDefaultsRepo.setLastFgDate()
        
        // check if actual session exists
        if !isAlive() {
            startNewSession()
        }
    }
    
    public func didEnterBackground() {
        guard let lastFg = userDefaultsRepo.getLastFgDate() else {
            userDefaultsRepo.setLastBgDate()
            return
        }
        
        updateTotalUsageTime(lastFgDate: lastFg)
        
        userDefaultsRepo.setLastBgDate()
    }
    
    private func isAlive() -> Bool {
        guard let lastBgDate = userDefaultsRepo.getLastBgDate() else {
            return false
        }
        
        let duration = Date.now.timeIntervalSince(lastBgDate)
        return duration <= hour
    }
    
    private func startNewSession(){
        finalizeSession()
        //TODO: call RequestReviewService to check distinct sessions number
        
        let newSession = SessionEntity(sessionId: UUID(), sessionStart: Date.now)
        sessionRepo.add(session: newSession)
    }
    
    private func finalizeSession() {
        let lastSession = sessionRepo.getLatest()
        lastSession?.sessionEnd = Date.now
    }
    
    private func updateTotalUsageTime(lastFgDate: Date) {
        let now = Date.now
        
        let usageTime = now.timeIntervalSince(lastFgDate)
        if usageTime > 0 {
            let total = (userDefaultsRepo.getTotalUsageSeconds() ?? 0) + usageTime
            userDefaultsRepo.setTotalUsageSeconds(seconds: total)
        }
    }
}

