//
//  SessionTrackerServiceProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

protocol SessionTrackerServiceProtocol {
    func willEnterForeground()
    func didEnterBackground()
}
