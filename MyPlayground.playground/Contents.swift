//: Playground - noun: a place where people can play

import UIKit

protocol HomeViewControllerDelegate: class {
    func didClickBanner()
}

class HomeViewController: UIViewController {
    weak var delegate: HomeViewControllerDelegate?
    
    func bannerClicked() {
        delegate?.didClickBanner()
    }
}

class DynamicViewController: UIViewController { }

class PagingMenuController {
    var views: [UIViewController] = []
    
    func setup() {
        views.append(HomeViewController())
        views.append(DynamicViewController())
        views.append(DynamicViewController())
    }
}

class SegmentedHomeViewController: HomeViewControllerDelegate {
    var pagingMenuController: PagingMenuController?
    
    func setupSubViews() {
        let pagingMenuController = PagingMenuController()
        pagingMenuController.setup()
        self.pagingMenuController = pagingMenuController
        setupHomeVCDelegate()
    }
    
    private func setupHomeVCDelegate() {
        guard let pagingMenuController = pagingMenuController else { return }
        for vc in pagingMenuController.views {
            guard let homeVC = vc as? HomeViewController else { continue }
            homeVC.delegate = self
        }
    }
    
    // HomeViewControllerDelegate implementation
    func didClickBanner() {
        print("a banner from Home view controller is clicked")
    }
    
    // dummy method
    func simulateBannerClickOnHomeVC() {
        guard let pagingMenuController = pagingMenuController else { return }
        for vc in pagingMenuController.views {
            guard let homeVC = vc as? HomeViewController else { continue }
            homeVC.bannerClicked()
        }
    }
}

/// Implementation
let segmentedHome = SegmentedHomeViewController()
segmentedHome.setupSubViews()
segmentedHome.simulateBannerClickOnHomeVC()
