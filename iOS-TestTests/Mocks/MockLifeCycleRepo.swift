//
//  MockLifeCycleRepo.swift
//  iOS-TestTests
//
//  Created by Mari Budko on 29.09.2025.
//

import Foundation
@testable import iOS_Test

final class MockLifeCycleRepo: AppLifecycleRepositoryProtocol {
    var total: TimeInterval
    var lastFg: Date?
    var lastBg: Date?
    
    init(total: TimeInterval, lastFg: Date? = nil, lastBg: Date? = nil) {
        self.total = total
        self.lastFg = lastFg
        self.lastBg = lastBg
    }
    
    func setLastFgDate(date: Date) {
        lastFg = date
    }
    
    func getLastFgDate() -> Date? { lastFg }
    
    func setLastBgDate(date: Date) {
        lastBg = date
    }
    
    func getLastBgDate() -> Date? { lastBg }
    
    func setTotalUsageSeconds(seconds: TimeInterval) {
        total = seconds
    }
    
    func getTotalUsageSeconds() -> TimeInterval { total }
}

