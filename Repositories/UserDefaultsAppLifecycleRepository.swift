//
//  UserDefaultsRepository.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

final class UserDefaultsAppLifecycleRepository: AppLifecycleRepositoryProtocol {
    
    func setLastFgDate() {
        
    }
    
    func getLastFgDate() -> Date? {
        return .now
    }
    
    func setLastBgDate() {
        
    }
    
    func getLastBgDate() -> Date? {
        return .now
    }
    
    func setTotalUsageSeconds(seconds: TimeInterval) {
        
    }
    
    func getTotalUsageSeconds() -> TimeInterval? {
        return 0
    }
}
