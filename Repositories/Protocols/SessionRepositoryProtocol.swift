//
//  SessionRepositoryProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

protocol SessionRepositoryProtocol: AnyObject {
    func add(session: SessionEntity)
    func getAllCompleted() -> [SessionEntity]
    func getLatest() -> SessionEntity?
    func update(session: SessionEntity)
    func removeAllNotActive()
}


//private func getActualSession() -> SessionEntity? {
//    guard let lastSession = sessionRepo.getLatestSession() else {
//        return nil
//    }
//   
//    if isAlive(lastBgDate: sessionRepo.getLastBackgroundDate() ?? .now) {
//        return lastSession
//    }
//        
//    return startNewSession()
//}
