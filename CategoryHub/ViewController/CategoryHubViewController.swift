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
  
  private lazy var collectionView: UICollectionView = {
    let layout = createCompositionalLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemGroupedBackground
    collectionView.dataSource = self
    collectionView.register(SliderBannerCell.self, forCellWithReuseIdentifier: SliderBannerCell.reuseIdentifier)
    collectionView.register(TextContentCell.self, forCellWithReuseIdentifier: TextContentCell.reuseIdentifier)
    collectionView.register(VideoBannerCell.self, forCellWithReuseIdentifier: VideoBannerCell.reuseIdentifier)
    collectionView.register(StaticBannerCell.self, forCellWithReuseIdentifier: StaticBannerCell.reuseIdentifier)
    collectionView.register(HighlightedProductCell.self, forCellWithReuseIdentifier: HighlightedProductCell.reuseIdentifier)
    return collectionView
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
    setupCollectionView()
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
  
  // MARK: - CollectionView Setup
  private func setupCollectionView() {
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(categoryHeaderView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Compositional Layout Setup
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { sectionIndex, _ in
      guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
      
      switch sectionType {
      case .sliderBanner:
        return CategoryHubViewController.createSliderBannerSectionLayout()
      case .textContent:
        return CategoryHubViewController.createTextContentSectionLayout()
      case .videoBanner:
        return CategoryHubViewController.createVideoBannerSectionLayout()
      case .staticBanner:
        return CategoryHubViewController.createStaticBannerSectionLayout()
      case .highlightedProduct:
        return CategoryHubViewController.createHighlightedProductSectionLayout()
      }
    }
  }
  
  private static func createSliderBannerSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(220)))
      .withSectionInterGroupSpacing(12)
      .withSectionInsets(NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 20, trailing: 16))
      .withOrthogonalScrollingBehavior(.groupPaging)
      .build()
  }
  
  private static func createTextContentSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80)))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80)))
      .withSectionInsets(NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16))
      .build()
  }
  
  private static func createVideoBannerSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)))
      .withSectionInsets(NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16))
      .build()
  }
  
  private static func createStaticBannerSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(140)))
      .withSectionInterGroupSpacing(12)
      .withSectionInsets(NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16))
      .build()
  }
  
  private static func createHighlightedProductSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
      .withItemInsets(NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180)))
      .withSectionInterGroupSpacing(12)
      .withSectionInsets(NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 20, trailing: 10))
      .build(repeatingSubItemCount: 2)
  }
}

// MARK: - UICollectionViewDataSource (Static Implementation)
extension CategoryHubViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionType = Section(rawValue: section) else { return 0 }
    
    switch sectionType {
    case .sliderBanner:
      return 3
    case .textContent:
      return 1
    case .videoBanner:
      return 1
    case .staticBanner:
      return 2
    case .highlightedProduct:
      return 4
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = Section(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch sectionType {
    case .sliderBanner:
      return collectionView.dequeueReusableCell(withReuseIdentifier: SliderBannerCell.reuseIdentifier, for: indexPath)
    case .textContent:
      return collectionView.dequeueReusableCell(withReuseIdentifier: TextContentCell.reuseIdentifier, for: indexPath)
    case .videoBanner:
      return collectionView.dequeueReusableCell(withReuseIdentifier: VideoBannerCell.reuseIdentifier, for: indexPath)
    case .staticBanner:
      return collectionView.dequeueReusableCell(withReuseIdentifier: StaticBannerCell.reuseIdentifier, for: indexPath)
    case .highlightedProduct:
      return collectionView.dequeueReusableCell(withReuseIdentifier: HighlightedProductCell.reuseIdentifier, for: indexPath)
    }
  }
}

#Preview {
  CategoryHubViewController()
}
