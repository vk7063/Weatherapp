//
//  SkeletonLoading.swift
//  Weather
//
//  Created by vinod on 13/03/23.
//

import UIKit
import SkeletonView

protocol SkeletonLoading {
    /// Outlet collection for all preview views
    var skeletableViews: [UIView] { get }

    /// Any changes to be done after skeleton loader is disabled. Eg. Applying gradient layers to buttons
    func updateSkeletonDesign(isEnding: Bool)
}

extension SkeletonLoading {
    /// Call to begin skeleton animation
    func startSkeletonLoading() {
        DispatchQueue.main.async {
            self.updateSkeletonDesign(isEnding: false)
            self.skeletableViews.forEach { view in
                view.isSkeletonable = true
                view.showAnimatedGradientSkeleton()

                if let textView = view as? UILabel {
                    textView.linesCornerRadius = 8
                }
            }
        }
    }

    /// Call after data to be shown is available
    func stopSkeletonLoading() {
        DispatchQueue.main.async {
            self.skeletableViews.forEach { view in
                view.hideSkeleton()
            }
            self.updateSkeletonDesign(isEnding: true)
        }
    }
}
