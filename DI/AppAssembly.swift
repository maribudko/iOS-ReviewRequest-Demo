//
//  AppAssembly.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Swinject

final class AppAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        // MARK: - CoreData
        container.register(CoreDataStack.self) { _ in
            CoreDataStack(modelName: "Model")
        }
        .inObjectScope(.container)
        
        // MARK: - Repositories
        container.register(SessionRepositoryProtocol.self) { resolver in
            guard let stack = resolver.resolve(CoreDataStack.self) else {
                fatalError("Can't resolve CoreDataStack")
            }
            return CoreDataSessionRepository(context: stack.viewContext)
        }
        .inObjectScope(.container)
        
        container.register(ReviewRepositoryProtocol.self) { _ in
            UserDefaultsReviewRepository()
        }
        .inObjectScope(.container)
        container.register(AppLifecycleRepositoryProtocol.self) { _ in
            UserDefaultsAppLifecycleRepository()
        }
        .inObjectScope(.container)
        
        // MARK: - Services
        container.register(SessionTrackerServiceProtocol.self) { resolver in
            guard
                let sessionRepo: SessionRepositoryProtocol = resolver.resolve(SessionRepositoryProtocol.self),
                let lifecycleRepo: AppLifecycleRepositoryProtocol = resolver.resolve(AppLifecycleRepositoryProtocol.self)
            else {
                fatalError("Can't resolve dependencies for SessionTrackerService")
            }
            
            return SessionTrackerService(
                sessionRepo: sessionRepo,
                lifecycleRepo: lifecycleRepo
            )
        }
        .inObjectScope(.container)
        
        container.register(ReviewRequestServiceProtocol.self) { resolver in
            guard
                let sessionRepo: SessionRepositoryProtocol = resolver.resolve(SessionRepositoryProtocol.self),
                let lifecycleRepo: AppLifecycleRepositoryProtocol = resolver.resolve(UserDefaultsAppLifecycleRepository.self),
                let reviewRepo: ReviewRepositoryProtocol = resolver.resolve(ReviewRepositoryProtocol.self)
            else {
                fatalError("Can't resolve dependencies for ReviewRequestService")
            }
            
            return ReviewRequestService(
                sessionRepo: sessionRepo,
                lifeCycleRepo: lifecycleRepo,
                reviewRepo: reviewRepo
            )
        }
        .inObjectScope(.container)
    }
}
