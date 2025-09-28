//
//  AppAssembly.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Swinject

final class AppAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(SessionRepositoryProtocol.self) { _ in CoreDataSessionRepository() }
        container.register(ReviewRepositoryProtocol.self) { _ in UserDefaultsReviewRepository() }
        container.register(AppLifecycleRepositoryProtocol.self) { _ in UserDefaultsAppLifecycleRepository() }
        
        container.register(SessionTrackerServiceProtocol.self) { resolver in
            guard
                let sessionRepo: SessionRepositoryProtocol = resolver.resolve(CoreDataSessionRepository.self),
                let userDefaultsRepo: AppLifecycleRepositoryProtocol = resolver.resolve(UserDefaultsAppLifecycleRepository.self)
            else {
                fatalError("Can't resolve dependencies for SessionTrackerService")
            }
            
            return SessionTrackerService(
                sessionRepo: sessionRepo,
                userDefaultsRepo: userDefaultsRepo
            )
        }
        
        container.register(ReviewRequestServiceProtocol.self) { resolver in
            guard
                let sessionRepo: SessionRepositoryProtocol = resolver.resolve(CoreDataSessionRepository.self),
                let lifecycleRepo: AppLifecycleRepositoryProtocol = resolver.resolve(UserDefaultsAppLifecycleRepository.self),
                let reviewRepo: ReviewRepositoryProtocol = resolver.resolve(UserDefaultsReviewRepository.self)
            else {
                fatalError("Can't resolve dependencies for ReviewRequestService")
            }
            
            return ReviewRequestService(
                sessionRepo: sessionRepo,
                lifeCycleRepo: lifecycleRepo,
                reviewRepo: reviewRepo
            )
        }
    }
}
