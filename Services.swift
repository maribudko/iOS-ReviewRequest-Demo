//
//  Services.swift
//

struct Services {
    static let sessionTrackerService = AppAssembler.shared.resolver.resolve(SessionTrackerServiceProtocol.self)
}
