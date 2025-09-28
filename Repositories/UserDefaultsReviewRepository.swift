//
//  UserDefaultsReviewRepository.swift
//  iOS-Test
//
//  Created by Mari Budko on 28.09.2025.
//

import Foundation

class UserDefaultsReviewRepository: ReviewRepositoryProtocol {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func setLastRequestDate(date: Date) {
        defaults.set(date.timeIntervalSince1970, forKey: UserDefaultsKeys.Review.lastRequestDate)
    }
    
    func getLastRequestDate() -> Date? {
        guard let lastRequestDate = defaults.value(forKey: UserDefaultsKeys.Review.lastRequestDate) as? TimeInterval else {
            return nil
        }
        return Date(timeIntervalSince1970: lastRequestDate)
    }
}
