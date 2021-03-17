//
//  TopRigthRotateAnimation.swift
//  myVK
//
//  Created by Вячеслав Поляков on 15.03.2021.
//

import UIKit

class TopRigthRotateAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
        
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceController = transitionContext.viewController(forKey: .from),
              let destinationController = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destinationController.view)
        destinationController.view.layer.anchorPoint = CGPoint(x:1, y: 0)
        destinationController.view.frame = sourceController.view.frame
        destinationController.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        UIView.animate(withDuration: animationDuration, animations: {
            destinationController.view.transform = .identity
            sourceController.view.layer.anchorPoint = CGPoint(x:0, y: 0)
            sourceController.view.frame = destinationController.view.frame
            sourceController.view.transform = CGAffineTransform(rotationAngle: .pi/2)
            
        }) { finished in
            sourceController.view.transform = .identity
            transitionContext.completeTransition(finished)
        }

        
    }

}
