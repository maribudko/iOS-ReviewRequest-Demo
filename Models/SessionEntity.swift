//
//  SessionEntity.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

class SessionEntity {
    var sessionId: UUID
    var sessionStart: Date
    var sessionEnd: Date?
    
    init(sessionId: UUID, sessionStart: Date, sessionEnd: Date? = nil) {
        self.sessionId = sessionId
        self.sessionStart = sessionStart
        self.sessionEnd = sessionEnd
    }
}
