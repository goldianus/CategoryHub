//
//  CategoryHubViewController.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import UIKit
import SwiftUI
import SnapKit
import Combine

// MARK: - CategoryHubViewController Implementation
final class CategoryHubViewController: UIViewController {
  
  private let categoryHeaderView = CategoryHeaderView()
  private let viewModel = CategoryHubViewModel()
  private var cancellables = Set<AnyCancellable>()
  
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
    bindViewModel()
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
    
    categoryHeaderView.onCategorySelected = { [weak self] index, categoryTitle in
      print("Selected category index: \(index), title: \(categoryTitle)")
      self?.viewModel.selectCategory(at: index)
    }
  }
  
  // MARK: - View Model Binding
  private func bindViewModel() {
    viewModel.$categories
      .receive(on: DispatchQueue.main)
      .sink { [weak self] categories in
        guard let self = self, !categories.isEmpty else { return }
        self.categoryHeaderView.setCategories(categories, defaultIndex: self.viewModel.selectedCategoryIndex)
      }
      .store(in: &cancellables)
    
    Publishers.CombineLatest(viewModel.$sectionsData, viewModel.$isLoading)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _, _ in
        /// note: karena saat ini menggunakan collectionView.reloadData(), seluruh UICollectionView akan di-render ulang secara penuh setiap kali kategori atau status loading berubah.
        self?.collectionView.reloadData()
      }
      .store(in: &cancellables)
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
      guard let self = self, let sectionType = Section(rawValue: sectionIndex) else { return nil }
      
      if self.viewModel.numberOfItems(at: sectionIndex) == 0 {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0.01)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0.01)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero
        return section
      }
      
      switch sectionType {
      case .sliderBanner:
        return self.createSliderBannerSectionLayout()
      case .textContent:
        return self.createTextContentSectionLayout()
      case .videoBanner:
        return self.createVideoBannerSectionLayout()
      case .staticBanner:
        return self.createStaticBannerSectionLayout()
      case .highlightedProduct:
        return self.createHighlightedProductSectionLayout()
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

// MARK: - UICollectionViewDataSource
extension CategoryHubViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfItems(at: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = Section(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    let sectionData = viewModel.sectionData(at: indexPath.section)
    let isLoading = viewModel.isLoading
    
    switch sectionType {
    case .sliderBanner:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderBannerCell.reuseIdentifier, for: indexPath) as? SliderBannerCell else {
        return UICollectionViewCell()
      }
      cell.showShimmer(isLoading)
      if !isLoading {
        if let banners = sectionData?.banners, banners.indices.contains(indexPath.item) {
          cell.configure(with: banners[indexPath.item])
        } else {
          cell.configure(with: sectionData?.banners?.first)
        }
      }
      return cell
      
    case .textContent:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextContentCell.reuseIdentifier, for: indexPath) as? TextContentCell else {
        return UICollectionViewCell()
      }
      cell.showShimmer(isLoading)
      if !isLoading {
        cell.configure(title: sectionData?.title, textContent: sectionData?.textContent)
      }
      return cell
      
    case .videoBanner:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoBannerCell.reuseIdentifier, for: indexPath) as? VideoBannerCell else {
        return UICollectionViewCell()
      }
      cell.showShimmer(isLoading)
      if !isLoading {
        cell.configure(title: sectionData?.title, description: sectionData?.description)
      }
      return cell
      
    case .staticBanner:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBannerCell.reuseIdentifier, for: indexPath) as? StaticBannerCell else {
        return UICollectionViewCell()
      }
      cell.showShimmer(isLoading)
      if !isLoading {
        if let banners = sectionData?.banners, banners.indices.contains(indexPath.item) {
          cell.configure(with: banners[indexPath.item], sectionTitle: sectionData?.title)
        } else {
          cell.configure(with: sectionData?.banners?.first, sectionTitle: sectionData?.title)
        }
      }
      return cell
      
    case .highlightedProduct:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HighlightedProductCell.reuseIdentifier, for: indexPath) as? HighlightedProductCell else {
        return UICollectionViewCell()
      }
      cell.showShimmer(isLoading)
      if !isLoading {
        cell.configure(categoryName: viewModel.selectedCategoryName, itemIndex: indexPath.item)
      }
      return cell
    }
  }
}

#Preview {
  CategoryHubViewController()
}
