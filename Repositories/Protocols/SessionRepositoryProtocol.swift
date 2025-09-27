//
//  SessionRepositoryProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

protocol SessionRepositoryProtocol: AnyObject {
    func addSession(session: SessionEntity)
    func getAllSessions() -> [SessionEntity]
    func getLatestSession() -> SessionEntity?
}
