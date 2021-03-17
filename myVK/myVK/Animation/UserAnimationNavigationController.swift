//
//  UserAnimationNavigationController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 15.03.2021.
//

import UIKit

class UserAnimationNavigationController: UINavigationController {
    
    fileprivate let interactiveTransitionAnimator = InteractiveTransitionAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        let edgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestureStarted))
        edgePanGestureRecognizer.edges = .left
        view.addGestureRecognizer(edgePanGestureRecognizer)
    }
    
    @objc private func edgePanGestureStarted(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransitionAnimator.hasStrated = true
            popViewController(animated: true)
        case .changed:
            let totalGestureDistance: CGFloat = 200
            let distance = recognizer.translation(in: recognizer.view).x
            let relativeDistance = distance/totalGestureDistance
            let progress = max(0, min(1, relativeDistance))
            interactiveTransitionAnimator.update(progress)
            interactiveTransitionAnimator.shouldFinish = progress > 0.35
        case .ended:
            interactiveTransitionAnimator.hasStrated = false
            if interactiveTransitionAnimator.shouldFinish {
                interactiveTransitionAnimator.finish()
            } else {
                interactiveTransitionAnimator.cancel()
            }
        case .cancelled:
            interactiveTransitionAnimator.hasStrated = false
            interactiveTransitionAnimator.cancel()
        default:
            break
        }
    }

}

extension UserAnimationNavigationController: UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return TopRigthRotateAnimation()
        case .pop:
            return TopRigthRotateAnimation()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }


    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransitionAnimator.hasStrated ? interactiveTransitionAnimator : nil
    }
    
}
