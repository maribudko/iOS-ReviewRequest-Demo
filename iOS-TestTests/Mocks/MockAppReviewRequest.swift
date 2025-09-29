//
//  MockAppReviewRequest.swift
//  iOS-TestTests
//
//  Created by Mari Budko on 29.09.2025.
//

import Foundation
@testable import iOS_Test

final class MockAppReviewRequest: iOS_Test.AppReviewRequestProtocol {
    func requestReview() {
        debugPrint("Review window shown")
    }
}
