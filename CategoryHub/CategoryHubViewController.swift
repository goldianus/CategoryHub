//
//  CategoryHubViewController.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import UIKit
import SwiftUI
import SnapKit

// MARK: - CategoryHubViewController Implementation
final class CategoryHubViewController: UIViewController {
  
  private let categoryHeaderView = CategoryHeaderView()
  
  private let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }()
  
  private let placeholderLabel: UILabel = {
    let label = UILabel()
    label.text = "Content Area"
    label.textColor = .systemGray
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.textAlignment = .center
    return label
  }()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    setupCategoryHeaderView()
    setupContentView()
  }
  
  // MARK: - Category Header View Setup
  private func setupCategoryHeaderView() {
    view.addSubview(categoryHeaderView)
    
    categoryHeaderView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }
    
    categoryHeaderView.onCartTap = {
      print("Cart icon tapped")
    }
    
    categoryHeaderView.onSearchTap = {
      print("Search bar tapped")
    }
    
    categoryHeaderView.onCategorySelected = { index, categoryTitle in
      print("Selected category index: \(index), title: \(categoryTitle)")
    }
  }
  
  // MARK: - Content View Setup
  private func setupContentView() {
    view.addSubview(contentView)
    contentView.addSubview(placeholderLabel)
    
    contentView.snp.makeConstraints { make in
      make.top.equalTo(categoryHeaderView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    placeholderLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}

#Preview {
  CategoryHubViewController()
}
