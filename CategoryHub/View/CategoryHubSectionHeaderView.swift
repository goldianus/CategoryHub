//
//  CategoryHubSectionHeaderView.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import UIKit
import SwiftUI
import SnapKit

// MARK: - Section Header View
final class CategoryHubSectionHeaderView: UICollectionReusableView {
  static let reuseIdentifier = "CategoryHubSectionHeaderView"
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.textColor = .label
    return label
  }()
  
  private let accentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBlue
    view.layer.cornerRadius = 2
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    addSubview(accentView)
    addSubview(titleLabel)
    
    accentView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
      make.width.equalTo(4)
      make.height.equalTo(18)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.leading.equalTo(accentView.snp.trailing).offset(8)
      make.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }
  
  func configure(title: String) {
    titleLabel.text = title
  }
}

#Preview {
  CategoryHubSectionHeaderView()
}

// MARK: - Category Header View
final class CategoryHeaderView: UIView {
  
  var onCartTap: (() -> Void)?
  var onSearchTap: (() -> Void)?
  var onCategorySelected: ((Int, String) -> Void)?
  
  private var categories: [String] = [
    "Brands",
    "adidas",
    "adidas Originals",
    "Asics",
    "Birkenstock",
    "Nike",
    "Puma"
  ]
  private var selectedIndex: Int = 0
  
  private let topContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  private let searchContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.3, alpha: 0.6)
    view.layer.cornerRadius = 6
    return view
  }()
  
  private let searchIconImageView: UIImageView = {
    let iv = UIImageView()
    let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
    iv.image = UIImage(systemName: "magnifyingglass", withConfiguration: config)
    iv.tintColor = UIColor.white.withAlphaComponent(0.8)
    return iv
  }()
  
  private let searchTextField: UITextField = {
    let tf = UITextField()
    tf.attributedPlaceholder = NSAttributedString(
      string: "Cari produk",
      attributes: [
        .foregroundColor: UIColor.white.withAlphaComponent(0.7),
        .font: UIFont.systemFont(ofSize: 14, weight: .regular)
      ]
    )
    tf.textColor = .white
    tf.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    tf.returnKeyType = .search
    return tf
  }()
  
  private let cartButton: UIButton = {
    let button = UIButton(type: .system)
    let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
    button.setImage(UIImage(systemName: "bag", withConfiguration: config), for: .normal)
    button.tintColor = .white
    return button
  }()
  
  private let tabScrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.showsHorizontalScrollIndicator = false
    sv.alwaysBounceHorizontal = true
    sv.backgroundColor = .black
    return sv
  }()
  
  private let tabStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .center
    stack.distribution = .fill
    stack.spacing = 20
    return stack
  }()
  
  private let underlineIndicatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 1.5
    return view
  }()
  
  private var tabButtons: [UIButton] = []
  
  // Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    backgroundColor = .black
    
    addSubview(topContainerView)
    topContainerView.addSubview(searchContainerView)
    searchContainerView.addSubview(searchIconImageView)
    searchContainerView.addSubview(searchTextField)
    topContainerView.addSubview(cartButton)
    
    addSubview(tabScrollView)
    tabScrollView.addSubview(tabStackView)
    tabScrollView.addSubview(underlineIndicatorView)
    
    setupActions()
    setupConstraints()
    renderCategoryTabs()
  }
  
  private func setupActions() {
    cartButton.addTarget(self, action: #selector(handleCartTap), for: .touchUpInside)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSearchTap))
    searchContainerView.addGestureRecognizer(tapGesture)
  }
  
  @objc private func handleCartTap() { onCartTap?() }
  @objc private func handleSearchTap() { onSearchTap?() }
  
  private func setupConstraints() {
    topContainerView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(48)
    }
    
    cartButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-12)
      make.centerY.equalToSuperview()
      make.size.equalTo(32)
    }
    
    searchContainerView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(12)
      make.trailing.equalTo(cartButton.snp.leading).offset(-8)
      make.centerY.equalToSuperview()
      make.height.equalTo(36)
    }
    
    searchIconImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(10)
      make.centerY.equalToSuperview()
      make.size.equalTo(16)
    }
    
    searchTextField.snp.makeConstraints { make in
      make.leading.equalTo(searchIconImageView.snp.trailing).offset(8)
      make.trailing.equalToSuperview().offset(-10)
      make.top.bottom.equalToSuperview()
    }
    
    tabScrollView.snp.makeConstraints { make in
      make.top.equalTo(topContainerView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(44)
    }
    
    tabStackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalToSuperview()
    }
    
    underlineIndicatorView.snp.makeConstraints { make in
      make.bottom.equalToSuperview().offset(-2)
      make.height.equalTo(3)
      make.leading.equalTo(tabStackView.snp.leading)
      make.width.equalTo(0)
    }
  }
  
  private func renderCategoryTabs() {
    tabButtons.forEach { $0.removeFromSuperview() }
    tabButtons.removeAll()
    
    for (index, title) in categories.enumerated() {
      let button = UIButton(type: .custom)
      button.setTitle(title, for: .normal)
      button.tag = index
      button.titleLabel?.font = index == selectedIndex ? UIFont.systemFont(ofSize: 15, weight: .bold) : UIFont.systemFont(ofSize: 15, weight: .semibold)
      button.setTitleColor(index == selectedIndex ? .white : UIColor.white.withAlphaComponent(0.75), for: .normal)
      button.addTarget(self, action: #selector(handleTabTap(_:)), for: .touchUpInside)
      
      tabStackView.addArrangedSubview(button)
      tabButtons.append(button)
    }
    
    layoutIfNeeded()
    updateUnderlinePosition(animated: false)
  }
  
  @objc private func handleTabTap(_ sender: UIButton) {
    let index = sender.tag
    guard index != selectedIndex else { return }
    setSelectedIndex(index, animated: true)
    onCategorySelected?(index, categories[index])
  }
  
  func setSelectedIndex(_ index: Int, animated: Bool = true) {
    guard index >= 0 && index < categories.count else { return }
    
    // Update font & warna untuk tab lama dan baru
    let prevButton = tabButtons[selectedIndex]
    prevButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    prevButton.setTitleColor(UIColor.white.withAlphaComponent(0.75), for: .normal)
    
    selectedIndex = index
    let selectedButton = tabButtons[selectedIndex]
    selectedButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    selectedButton.setTitleColor(.white, for: .normal)
    
    updateUnderlinePosition(animated: animated)
    scrollToSelectedTab(selectedButton, animated: animated)
  }
  
  private func updateUnderlinePosition(animated: Bool) {
    guard selectedIndex < tabButtons.count else { return }
    let selectedButton = tabButtons[selectedIndex]
    
    let targetLeading = selectedButton.frame.origin.x
    let targetWidth = selectedButton.frame.width
    
    underlineIndicatorView.snp.remakeConstraints { make in
      make.bottom.equalToSuperview().offset(-2)
      make.height.equalTo(3)
      make.leading.equalTo(tabStackView.snp.leading).offset(targetLeading)
      make.width.equalTo(targetWidth)
    }
    
    if animated {
      UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
        self.tabScrollView.layoutIfNeeded()
      }
    } else {
      tabScrollView.layoutIfNeeded()
    }
  }
  
  private func scrollToSelectedTab(_ button: UIButton, animated: Bool) {
    let rect = button.frame
    let targetRect = CGRect(x: rect.origin.x - 24, y: rect.origin.y, width: rect.width + 48, height: rect.height)
    tabScrollView.scrollRectToVisible(targetRect, animated: animated)
  }
  
  func setCategories(_ categories: [String], defaultIndex: Int = 1) {
    self.categories = categories
    self.selectedIndex = defaultIndex
    renderCategoryTabs()
  }
}

#Preview {
  CategoryHeaderView()
}
