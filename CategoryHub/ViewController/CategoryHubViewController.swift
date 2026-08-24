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
    return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
      guard let self = self else { return nil }
      
      switch sectionIndex {
      case 0:
        return self.createSliderBannerSectionLayout()
      case 1:
        return self.createTextContentSectionLayout()
      case 2:
        return self.createVideoBannerSectionLayout()
      case 3:
        return self.createStaticBannerSectionLayout()
      case 4:
        return self.createHighlightedProductSectionLayout()
      default:
        return nil
      }
    }
  }
  
  private func createSliderBannerSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(220)))
      .withSectionInterGroupSpacing(12)
      .withSectionInsets(NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 20, trailing: 16))
      .withOrthogonalScrollingBehavior(.groupPaging)
      .build()
  }
  
  private func createTextContentSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80)))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80)))
      .withSectionInsets(NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16))
      .build()
  }
  
  private func createVideoBannerSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)))
      .withSectionInsets(NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16))
      .build()
  }
  
  private func createStaticBannerSectionLayout() -> NSCollectionLayoutSection {
    CompositionalLayoutBuilder()
      .withItemLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      .withGroupLayoutSize(NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(140)))
      .withSectionInterGroupSpacing(12)
      .withSectionInsets(NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16))
      .build()
  }
  
  private func createHighlightedProductSectionLayout() -> NSCollectionLayoutSection {
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
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 3
    case 1:
      return 1
    case 2:
      return 1
    case 3:
      return 2
    case 4:
      return 4
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderBannerCell.reuseIdentifier, for: indexPath)
      return cell
    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextContentCell.reuseIdentifier, for: indexPath)
      return cell
    case 2:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoBannerCell.reuseIdentifier, for: indexPath)
      return cell
    case 3:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBannerCell.reuseIdentifier, for: indexPath)
      return cell
    case 4:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HighlightedProductCell.reuseIdentifier, for: indexPath)
      return cell
    default:
      return UICollectionViewCell()
    }
  }
}

#Preview {
  CategoryHubViewController()
}
