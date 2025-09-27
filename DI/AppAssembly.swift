//
//  AppAssembly.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Swinject

public final class AppAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Swinject.Container) {
        container.register(SessionRepositoryProtocol.self) { _ in CoreDataSessionRepository() }
        container.register(ReviewRepositoryProtocol.self) { _ in CoreDataReviewRepository() }
    }
}
