//
//  FadeOutAnimationController.swift
//  StoreSearch
//
//  Created by Denis Nurislamov on 17.05.2023.
//

import UIKit

class FadeOutAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            let time = transitionDuration(using: transitionContext)
            UIView.animate(withDuration: time) {
                fromView.alpha = 0
            } completion: { finished in
                transitionContext.completeTransition(finished)
            }

        }
    }
    
    
}
