//
//  SessionRepositoryProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

protocol SessionRepositoryProtocol: AnyObject {
    func add(session: SessionModel)
    func getAllCompleted() -> [SessionModel]
    func getLatest() -> SessionModel?
    func update(session: SessionModel)
    func removeAllCompleted()
}
