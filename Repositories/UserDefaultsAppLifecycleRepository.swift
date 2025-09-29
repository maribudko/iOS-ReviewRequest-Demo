//
//  UserDefaultsRepository.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

final class UserDefaultsAppLifecycleRepository: AppLifecycleRepositoryProtocol {
    private let defaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }
    
    func setLastFgDate(date: Date) {
        defaults.set(date.timeIntervalSince1970, forKey: UserDefaultsKeys.Session.lastForegroundDate)
    }
    
    func getLastFgDate() -> Date? {
        let lastFgDate = defaults.double(forKey: UserDefaultsKeys.Session.lastForegroundDate)
        
        return lastFgDate == 0 ? nil : Date(timeIntervalSince1970: lastFgDate)
    }
    
    func setLastBgDate(date: Date) {
        defaults.set(date.timeIntervalSince1970, forKey: UserDefaultsKeys.Session.lastBackgroundDate)
    }
    
    func getLastBgDate() -> Date? {
        let lastBgDate = defaults.double(forKey: UserDefaultsKeys.Session.lastBackgroundDate)
        
        return lastBgDate == 0 ? nil : Date(timeIntervalSince1970: lastBgDate)
    }
    
    func setTotalUsageSeconds(seconds: TimeInterval) {
        defaults.set(seconds, forKey: UserDefaultsKeys.Session.totalUsageSeconds)
    }
    
    func getTotalUsageSeconds() -> TimeInterval {
        let totalUsageSeconds = defaults.double(forKey: UserDefaultsKeys.Session.totalUsageSeconds)
        
        return totalUsageSeconds
    }
}
