//
//  DummyViewController.swift
//  iOS-Test
//

import UIKit
import FirebaseAnalytics
import StoreKit

protocol DummyDisplayLogic: AnyObject {
    func display(model: DummyModels.Load.ViewModel)
}

class DummyViewController: UIViewController, AppReviewRequestProtocol {
    
    var interactor: DummyBusinessLogic?
    var router: DummyRoutingLogic?
    
    // MARK: - Outlets
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.load(request: .init())
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Analytics.logEvent("dummy_opened", parameters: [
            "source": "debug"
        ])
        
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: "Dummy",
            AnalyticsParameterScreenClass: "DummyViewController"
        ])
        
        Services.reviewRequestService.evaluateAndRequestIfNeeded(reviewRequest: self)
    }
    
    // MARK: - Common
    func setupUI() {
        self.navigationItem.title = "Hello world!"
    }
    
    func requestReview() {
        let scene = self.view.window?.windowScene
        ?? UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
        
        guard let scene else { return }
        SKStoreReviewController.requestReview(in: scene)
    }
}

extension DummyViewController: DummyDisplayLogic {
    func display(model: DummyModels.Load.ViewModel) {
        
    }
}
