//
//  SpyReviewRepo.swift
//  iOS-TestTests
//
//  Created by Mari Budko on 29.09.2025.
//

import Foundation
@testable import iOS_Test

final class SpyReviewRepo: ReviewRepositoryProtocol {
    private(set) var lastSetDate: Date?
    
    func setLastRequestDate(date: Date) {
        lastSetDate = date
    }
    
    func getLastRequestDate() -> Date? {
        nil
    }
    
    
}
