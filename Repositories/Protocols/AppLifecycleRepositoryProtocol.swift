//
//  BgFgRepositoryProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

protocol AppLifecycleRepositoryProtocol: AnyObject {
    func setLastFgDate()
    func getLastFgDate() -> Date?
    func setLastBgDate()
    func getLastBgDate() -> Date?
    func setTotalUsageSeconds(seconds: TimeInterval)
    func getTotalUsageSeconds() -> TimeInterval?
}
