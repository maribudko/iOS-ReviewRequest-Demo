//
//  ReviwRequestServiceProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation
import UIKit

protocol ReviewRequestServiceProtocol {
    func evaluateAndRequestIfNeeded(reviewRequest: AppReviewRequestProtocol)
}
