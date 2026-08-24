//
//  ShimmerView.swift
//  CategoryHub
//
//  Created by Goldianus SM on 24/08/26.
//

import UIKit

final class ShimmerView: UIView {
  
  private let gradientLayer = CAGradientLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupShimmer()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupShimmer()
  }
  
  private func setupShimmer() {
    layer.cornerRadius = 8
    clipsToBounds = true
    
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradientLayer.locations = [0.0, 0.5, 1.0]
    
    layer.addSublayer(gradientLayer)
    updateColors()
  }
  
  private func updateColors() {
    let isDark = traitCollection.userInterfaceStyle == .dark
    
    let baseColor: UIColor = isDark
      ? UIColor(white: 0.20, alpha: 1.0)
      : UIColor(white: 0.85, alpha: 1.0)
    
    let highlightColor: UIColor = isDark
      ? UIColor(white: 0.34, alpha: 1.0)
      : UIColor(white: 0.95, alpha: 1.0)
    
    backgroundColor = baseColor
    gradientLayer.colors = [baseColor.cgColor, highlightColor.cgColor, baseColor.cgColor]
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
      updateColors()
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }
  
  func startAnimating() {
    gradientLayer.removeAnimation(forKey: "shimmerAnimation")
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [-1.0, -0.5, 0.0]
    animation.toValue = [1.0, 1.5, 2.0]
    animation.duration = 1.2
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    animation.repeatCount = .infinity
    gradientLayer.add(animation, forKey: "shimmerAnimation")
    isHidden = false
  }
  
  func stopAnimating() {
    gradientLayer.removeAnimation(forKey: "shimmerAnimation")
    isHidden = true
  }
}
