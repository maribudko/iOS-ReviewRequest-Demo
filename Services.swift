//
//  Services.swift
//

struct Services {
    static let resolver = AppAssembler.shared.resolver
    
    static let sessionTrackerService = resolver.resolve(SessionTrackerServiceProtocol.self)
    static let reviewRequestService = resolver.resolve(ReviewRequestServiceProtocol.self)
}
