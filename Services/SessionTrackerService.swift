//
//  SessionTrackerService.swift
//  iOS-Test
//
//  Created by Mari Budko on 26.09.2025.
//

import Foundation

final class SessionTrackerService: SessionTrackerServiceProtocol {
    let sessionRepo = AppAssembler.shared.resolver.resolve(SessionRepositoryProtocol.self)
    
    func willEnterForeground() {
        
    }
    
    func didEnterBackground() {
        
    }
    
   
}

