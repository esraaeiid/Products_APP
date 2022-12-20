//
//  TransitionManager.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 20/12/2022.
//

import Foundation
import UIKit


///Resources: [https://medium.com/geekculture/custom-view-controllers-transitions-aa8c052f8049]

final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval
    private var operation = UINavigationController.Operation.push
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        animateTransition(from: fromViewController, to: toViewController, with: transitionContext)
    }
}

// MARK: - UINavigationControllerDelegate

extension TransitionManager: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.operation = operation
        
        if operation == .push {
            return self
        }
        
        return nil
    }
}


// MARK: - Animations

private extension TransitionManager {
    func animateTransition(from fromViewController: UIViewController, to toViewController: UIViewController, with context: UIViewControllerContextTransitioning) {
        switch operation {
        case .push:
            guard
                let productsViewController = fromViewController as? ProductsViewController,
                let detailsViewController = toViewController as? ProductDetailViewController
            else { return }
            
            presentViewController(detailsViewController, from: productsViewController, with: context)
            
        case .pop:
            guard
                let detailsViewController = fromViewController as? ProductDetailViewController,
                let productsViewController = toViewController as? ProductsViewController
            else { return }
            
            dismissViewController(detailsViewController, to: productsViewController)
            
        default:
            break
        }
    }
    
    func presentViewController(_ toViewController: ProductDetailViewController, from fromViewController: ProductsViewController, with context: UIViewControllerContextTransitioning) {
        
        guard
            let productCell = fromViewController.currentCell,
            let productCoverImageView = fromViewController.currentCell?.productImageView,
            let productDetailImageView = toViewController.productImageView
        else { return}
        
        toViewController.view.layoutIfNeeded()
        
        let containerView = context.containerView
        
        let snapshotContentView = UIView()
        snapshotContentView.backgroundColor = .white
        snapshotContentView.frame = containerView.convert(productCell.contentView.frame, from: productCell)
        snapshotContentView.layer.cornerRadius = productCell.contentView.layer.cornerRadius
        
        let snapshotProductCoverImageView = UIImageView()
        snapshotProductCoverImageView.clipsToBounds = true
        snapshotProductCoverImageView.contentMode = productCoverImageView.contentMode
//        snapshotProductCoverImageView.image = productCoverImageView.image
        snapshotProductCoverImageView.layer.cornerRadius = productCoverImageView.layer.cornerRadius
        snapshotProductCoverImageView.frame = containerView.convert(productCoverImageView.frame, from: productCell)
        
        
        containerView.addSubview(toViewController.view)

        containerView.addSubview(snapshotContentView)
        containerView.addSubview(snapshotProductCoverImageView)
        toViewController.view.isHidden = true
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            snapshotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
            snapshotProductCoverImageView.frame = containerView.convert(productDetailImageView.frame, from: productDetailImageView)
            snapshotProductCoverImageView.layer.cornerRadius = 0
        }

        animator.addCompletion { position in
            toViewController.view.isHidden = false
            snapshotProductCoverImageView.removeFromSuperview()
            snapshotContentView.removeFromSuperview()
            context.completeTransition(position == .end)
        }

        animator.startAnimation()
    }
    
    func dismissViewController(_ fromViewController: ProductDetailViewController, to toViewController: ProductsViewController) {
        
    }
}
