//
//  AnimationsViewController.swift
//  CollectionViewAndAnimationsApp
//
//  Created by Zharas Muzarap on 30.01.2023.
//

import Foundation
import UIKit

class AnimationsViewController: UIViewController {
	
	@IBOutlet weak var animatedView: UIView!

	@IBOutlet weak var leadingConstraint: NSLayoutConstraint!
	@IBOutlet weak var trailingConstraint: NSLayoutConstraint!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	
	@IBAction func buttonTapped(_ sender: UIButton) {
		animateTransitionAnimation()
	}
	
	func animateConstraintAnimation() {
		leadingConstraint.isActive = false
		trailingConstraint.isActive = true
		trailingConstraint.constant = 20
		
		UIView.animate(withDuration: 1,
					   delay: 0,
					   options: [.curveEaseInOut, .repeat]
		) {
			self.view.layoutIfNeeded()
		}
	}
	
	func animateSpringAnimation() {
		leadingConstraint.isActive = false
		trailingConstraint.isActive = true
		trailingConstraint.constant = 80
		
		UIView.animate(withDuration: 1.5,
					   delay: 0,
					   usingSpringWithDamping: 0.3,
					   initialSpringVelocity: 0,
					   options: [.curveEaseOut, .repeat]
		) {
			self.view.layoutIfNeeded()
		}
	}
	
	func animateKeyframeAnimation() {
		leadingConstraint.isActive = false
		trailingConstraint.isActive = true
		
		UIView.animateKeyframes(withDuration: 4,
								delay: 0,
								options: [.calculationModeLinear]
		) {
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
				self.trailingConstraint.constant = 140
				self.view.layoutIfNeeded()
			}
			UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.35) {
				self.animatedView.transform = CGAffineTransform(rotationAngle: .pi)
				self.animatedView.backgroundColor = .systemBlue
				self.trailingConstraint.constant = 100
				self.view.layoutIfNeeded()
			}
			UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.3) {
				self.animatedView.backgroundColor = .systemGreen
				self.trailingConstraint.constant = 20
				self.view.layoutIfNeeded()
			}
			UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1) {
				self.leadingConstraint.isActive = true
				self.trailingConstraint.isActive = false
				self.view.layoutIfNeeded()
			}
		}
	}
	
	func animateTransitionAnimation() {
		UIView.transition(with: animatedView,
						  duration: 0.7,
						  options: [.transitionCrossDissolve]) {
			self.animatedView.backgroundColor = .systemBlue
		}
	}
}
