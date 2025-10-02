//
//  BgFgRepositoryProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

protocol AppLifecycleRepositoryProtocol {
    func setLastFgDate(date: Date)
    func getLastFgDate() -> Date?
    func setLastBgDate(date: Date)
    func getLastBgDate() -> Date?
    func setTotalUsageSeconds(seconds: TimeInterval)
    func getTotalUsageSeconds() -> TimeInterval
}
