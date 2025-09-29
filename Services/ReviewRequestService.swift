//
//  ReviewRequestService.swift
//  iOS-Test
//
//  Created by Mari Budko on 26.09.2025.
//

import Foundation
import StoreKit

final class ReviewRequestService: ReviewRequestServiceProtocol {
    private let sessionRepo: SessionRepositoryProtocol
    private let lifeCycleRepo: AppLifecycleRepositoryProtocol
    private let reviewRepo: ReviewRepositoryProtocol
    private let dateProvider: () -> Date
    
    private let distinctSessionsValue = 2 // 2 distinct sessions
    private let minUsageSeconds: TimeInterval = 10 * 60 // 10 min
    private let cooldown: TimeInterval = 3 * 24 * 60 * 60 // 3 days
    
    init(sessionRepo: SessionRepositoryProtocol,
         lifeCycleRepo: AppLifecycleRepositoryProtocol,
         reviewRepo: ReviewRepositoryProtocol,
         dateProvider: @escaping () -> Date = { Date() }
    ) {
        self.sessionRepo = sessionRepo
        self.lifeCycleRepo = lifeCycleRepo
        self.reviewRepo = reviewRepo
        self.dateProvider = dateProvider
    }
    
    func evaluateAndRequestIfNeeded(on viewController: UIViewController?) {
        guard isEligible(now: dateProvider()) else { return }
        requestReview(on: viewController)
    }
    
    func requestReview(on viewController: UIViewController?) {
        let now = dateProvider()
        let scene = viewController?.view.window?.windowScene
        ?? UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
        
        guard let scene else { return }
        
#if DEBUG
        print("Store Review is called")
#else
        SKStoreReviewController.requestReview(in: scene)
#endif
        reviewRepo.setLastRequestDate(date: now)
        sessionRepo.removeAllCompleted()
        
    }
    
    // MARK: - private
    
    private func isEligible(now: Date) -> Bool {
        // check distinct sessions condition
        let sessionsOk = sessionRepo.getAllCompleted().count >= distinctSessionsValue
        
        // check usage time
        let saved = lifeCycleRepo.getTotalUsageSeconds()
        let tail: TimeInterval = {
            guard let lastFg = lifeCycleRepo.getLastFgDate() else { return 0 }
            return max(0, now.timeIntervalSince(lastFg))
        }()
        let usageOk = (saved + tail) >= minUsageSeconds
        
        //check cooldown
        let cooldownOk: Bool = {
            guard let lastRequest = reviewRepo.getLastRequestDate() else {
                return true
            }
            return now.timeIntervalSince(lastRequest) >= cooldown
        }()
        
        return sessionsOk && usageOk && cooldownOk
    }
}
