//
//  SessionTrackerService.swift
//  iOS-Test
//
//  Created by Mari Budko on 26.09.2025.
//

import Foundation

final class SessionTrackerService: SessionTrackerServiceProtocol {
    private let sessionRepo: SessionRepositoryProtocol
    private let lifecycleRepo: AppLifecycleRepositoryProtocol
    private let dateProvider: () -> Date
    
    private let hour: TimeInterval = 60 * 60
    
    init(
        sessionRepo: SessionRepositoryProtocol,
        lifecycleRepo: AppLifecycleRepositoryProtocol,
        dateProvider: @escaping () -> Date = { Date() }
    ) {
        self.sessionRepo = sessionRepo
        self.lifecycleRepo = lifecycleRepo
        self.dateProvider = dateProvider
    }
    
    public func willEnterForeground() {
        let now = dateProvider()
        lifecycleRepo.setLastFgDate(date: now)
        
        // check if actual session exists
        if !isAlive(now: now) {
            startNewSession(now: now)
        }
    }
    
    public func didEnterBackground() {
        let now = dateProvider()
        
        guard let lastFg = lifecycleRepo.getLastFgDate() else {
            lifecycleRepo.setLastBgDate(date: now)
            return
        }
        
        updateTotalUsageTime(lastFgDate: lastFg)
        
        lifecycleRepo.setLastBgDate(date: now)
    }
    
    //MARK: - Private
    
    private func isAlive(now: Date) -> Bool {
        guard let lastBgDate = lifecycleRepo.getLastBgDate() else { return false }
        
        let duration = now.timeIntervalSince(lastBgDate)
        return duration <= hour
    }
    
    private func startNewSession(now: Date){
        finalizeSession(now: now)
        
        let newSession = SessionModel(sessionId: UUID(), sessionStart: now)
        sessionRepo.add(session: newSession)
    }
    
    private func finalizeSession(now: Date) {
        let lastSession = sessionRepo.getLatest()
        lastSession?.sessionEnd = now
    }
    
    private func updateTotalUsageTime(lastFgDate: Date) {
        let now = Date.now
        
        let usageTime = now.timeIntervalSince(lastFgDate)
        if usageTime > 0 {
            let total = lifecycleRepo.getTotalUsageSeconds() + usageTime
            lifecycleRepo.setTotalUsageSeconds(seconds: total)
        }
    }
}

