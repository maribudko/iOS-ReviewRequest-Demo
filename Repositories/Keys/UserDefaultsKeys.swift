//
//  UserDefaultsKeys.swift
//  iOS-Test
//
//  Created by Mari Budko on 28.09.2025.
//

import Foundation

enum UserDefaultsKeys {
    enum Review {
        static let lastRequestDate = "review.lastRequestDate"
    }
    
    enum Session {
        static let lastForegroundDate = "session.lastFgDate"
        static let lastBackgroundDate = "session.lastBgDate"
        static let totalUsageSeconds = "session.totalUsageSeconds"
    }
}
