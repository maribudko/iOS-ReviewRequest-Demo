//
//  ReviewRepositoryProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation

protocol ReviewRepositoryProtocol: AnyObject {
    func setLastRequestDate(date: Date)
    func getLastRequestDate() -> Date?
}
