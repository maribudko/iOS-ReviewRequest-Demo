//
//  ReviwRequestServiceProtocol.swift
//  iOS-Test
//
//  Created by Mari Budko on 27.09.2025.
//

import Foundation
import UIKit

protocol ReviewRequestServiceProtocol: AnyObject {
    func evaluateAndRequestIfNeeded(on viewController: UIViewController?)
    func requestReview(on viewController: UIViewController?)
}
