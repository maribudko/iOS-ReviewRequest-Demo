//
//  SessionEntity.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

class SessionEntity {
    var sessionStart: TimeInterval
    var sessionEnd: TimeInterval?
    var sessionDurationSecs: Int?
    var sessionId: UUID
    
    init(sessionStart: TimeInterval, sessionEnd: TimeInterval?, sessionDurationSecs: Int?, sessionId: UUID) {
        self.sessionStart = sessionStart
        self.sessionEnd = sessionEnd
        self.sessionDurationSecs = sessionDurationSecs
        self.sessionId = sessionId
    }
}
