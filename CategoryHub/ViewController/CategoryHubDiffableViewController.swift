//
//  CategoryHubDiffableViewController.swift
//  CategoryHub
//
//  Created by Goldianus SM on 25/08/26.
//

import UIKit
import SwiftUI
import SnapKit
import Combine

// MARK: - Diffable Identifiers
nonisolated enum CategoryHubItem: Hashable, Sendable {
  case sliderBanner(index: Int)
  case textContent
  case videoBanner
  case staticBanner(index: Int)
  case highlightedProduct(index: Int)
  case skeleton(section: Section, index: Int)
}

private enum CategoryHubItemPayload: Equatable {
  case banner(ContentManagementSystemBanner)
  case text(title: String?, textContent: String?)
  case video(title: String?, description: String?)
  case staticBanner(banner: ContentManagementSystemBanner, sectionTitle: String?)
  case product(categoryName: String, index: Int)
}

// MARK: - CategoryHubDiffableViewController Implementation
@MainActor
final class CategoryHubDiffableViewController: UIViewController {
  private let categoryHeaderView = CategoryHeaderView()
  private let viewModel = CategoryHubViewModel()
  private var cancellables = Set<AnyCancellable>()
  private var payloads: [CategoryHubItem: CategoryHubItemPayload] = [:]
  private var hasAppliedSnapshot = false
  
  private lazy var dataSource: UICollectionViewDiffableDataSource<Section, CategoryHubItem> = makeDataSource()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    collectionView.backgroundColor = .systemGroupedBackground
    return collectionView
  }()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
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
        guard let self, !categories.isEmpty else { return }
        categoryHeaderView.setCategories(categories, defaultIndex: viewModel.selectedCategoryIndex)
      }
      .store(in: &cancellables)
    
    Publishers.CombineLatest(viewModel.$sectionsData, viewModel.$isLoading)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _, _ in
        self?.applySnapshot()
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
    
    collectionView.dataSource = dataSource
  }
  
  // MARK: - Cell Registrations
  private func makeSliderBannerRegistration() -> UICollectionView.CellRegistration<SliderBannerCell, CategoryHubItem> {
    UICollectionView.CellRegistration { [weak self] cell, _, item in
      guard let self else { return }
      if case .skeleton = item {
        cell.showShimmer(true)
        return
      }
      cell.showShimmer(false)
      if case .banner(let banner) = payloads[item] {
        cell.configure(with: banner)
      }
    }
  }
  
  private func makeTextContentRegistration() -> UICollectionView.CellRegistration<TextContentCell, CategoryHubItem> {
    UICollectionView.CellRegistration { [weak self] cell, _, item in
      guard let self else { return }
      if case .skeleton = item {
        cell.showShimmer(true)
        return
      }
      cell.showShimmer(false)
      if case .text(let title, let textContent) = payloads[item] {
        cell.configure(title: title, textContent: textContent)
      }
    }
  }
  
  private func makeVideoBannerRegistration() -> UICollectionView.CellRegistration<VideoBannerCell, CategoryHubItem> {
    UICollectionView.CellRegistration { [weak self] cell, _, item in
      guard let self else { return }
      if case .skeleton = item {
        cell.showShimmer(true)
        return
      }
      cell.showShimmer(false)
      if case .video(let title, let description) = payloads[item] {
        cell.configure(title: title, description: description)
      }
    }
  }
  
  private func makeStaticBannerRegistration() -> UICollectionView.CellRegistration<StaticBannerCell, CategoryHubItem> {
    UICollectionView.CellRegistration { [weak self] cell, _, item in
      guard let self else { return }
      if case .skeleton = item {
        cell.showShimmer(true)
        return
      }
      cell.showShimmer(false)
      if case .staticBanner(let banner, let sectionTitle) = payloads[item] {
        cell.configure(with: banner, sectionTitle: sectionTitle)
      }
    }
  }
  
  private func makeHighlightedProductRegistration() -> UICollectionView.CellRegistration<HighlightedProductCell, CategoryHubItem> {
    UICollectionView.CellRegistration { [weak self] cell, _, item in
      guard let self else { return }
      if case .skeleton = item {
        cell.showShimmer(true)
        return
      }
      cell.showShimmer(false)
      if case .product(let categoryName, let index) = payloads[item] {
        cell.configure(categoryName: categoryName, itemIndex: index)
      }
    }
  }
  
  // MARK: - UICollectionViewDiffableDataSource Configuration
  private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, CategoryHubItem> {
    let sliderBannerRegistration = makeSliderBannerRegistration()
    let textContentRegistration = makeTextContentRegistration()
    let videoBannerRegistration = makeVideoBannerRegistration()
    let staticBannerRegistration = makeStaticBannerRegistration()
    let highlightedProductRegistration = makeHighlightedProductRegistration()
    
    return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
      switch item {
      case .sliderBanner, .skeleton(.sliderBanner, _):
        collectionView.dequeueConfiguredReusableCell(using: sliderBannerRegistration, for: indexPath, item: item)
      case .textContent, .skeleton(.textContent, _):
        collectionView.dequeueConfiguredReusableCell(using: textContentRegistration, for: indexPath, item: item)
      case .videoBanner, .skeleton(.videoBanner, _):
        collectionView.dequeueConfiguredReusableCell(using: videoBannerRegistration, for: indexPath, item: item)
      case .staticBanner, .skeleton(.staticBanner, _):
        collectionView.dequeueConfiguredReusableCell(using: staticBannerRegistration, for: indexPath, item: item)
      case .highlightedProduct, .skeleton(.highlightedProduct, _):
        collectionView.dequeueConfiguredReusableCell(using: highlightedProductRegistration, for: indexPath, item: item)
      }
    }
  }
  
  // MARK: - Snapshot Application
  private func applySnapshot() {
    let previousSnapshot = dataSource.snapshot()
    let previousPayloads = payloads
    let (snapshot, nextPayloads) = makeContentSnapshot()
    
    let itemsToReconfigure = snapshot.itemIdentifiers.filter { item in
      previousSnapshot.indexOfItem(item) != nil && previousPayloads[item] != nextPayloads[item]
    }
    
    payloads = nextPayloads
    
    if hasAppliedSnapshot,
       snapshot.sectionIdentifiers == previousSnapshot.sectionIdentifiers,
       snapshot.itemIdentifiers == previousSnapshot.itemIdentifiers,
       itemsToReconfigure.isEmpty {
      return
    }
    
    var snapshotToApply = snapshot
    if !itemsToReconfigure.isEmpty {
      snapshotToApply.reconfigureItems(itemsToReconfigure)
    }
    
    dataSource.apply(snapshotToApply, animatingDifferences: hasAppliedSnapshot)
    hasAppliedSnapshot = true
  }
  
  private func makeContentSnapshot() -> (
    NSDiffableDataSourceSnapshot<Section, CategoryHubItem>,
    [CategoryHubItem: CategoryHubItemPayload]
  ) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, CategoryHubItem>()
    snapshot.appendSections(Section.allCases)
    var nextPayloads: [CategoryHubItem: CategoryHubItemPayload] = [:]
    
    if viewModel.isLoading {
      snapshot.appendItems((0..<2).map { .skeleton(section: .sliderBanner, index: $0) }, toSection: .sliderBanner)
      snapshot.appendItems([.skeleton(section: .textContent, index: 0)], toSection: .textContent)
      snapshot.appendItems([.skeleton(section: .videoBanner, index: 0)], toSection: .videoBanner)
      snapshot.appendItems([.skeleton(section: .staticBanner, index: 0)], toSection: .staticBanner)
      snapshot.appendItems((0..<4).map { .skeleton(section: .highlightedProduct, index: $0) }, toSection: .highlightedProduct)
      return (snapshot, nextPayloads)
    }
    
    for section in Section.allCases {
      guard let sectionData = viewModel.sectionData(at: section.rawValue) else { continue }
      switch section {
      case .sliderBanner:
        guard let banners = sectionData.banners else { continue }
        var items: [CategoryHubItem] = []
        for (index, banner) in banners.enumerated() {
          let item = CategoryHubItem.sliderBanner(index: index)
          items.append(item)
          nextPayloads[item] = .banner(banner)
        }
        snapshot.appendItems(items, toSection: .sliderBanner)
      case .textContent:
        guard sectionData.textContent != nil else { continue }
        nextPayloads[.textContent] = .text(title: sectionData.title, textContent: sectionData.textContent)
        snapshot.appendItems([.textContent], toSection: .textContent)
      case .videoBanner:
        guard sectionData.videoURL != nil else { continue }
        nextPayloads[.videoBanner] = .video(title: sectionData.title, description: sectionData.description)
        snapshot.appendItems([.videoBanner], toSection: .videoBanner)
      case .staticBanner:
        guard let banners = sectionData.banners else { continue }
        var items: [CategoryHubItem] = []
        for (index, banner) in banners.enumerated() {
          let item = CategoryHubItem.staticBanner(index: index)
          items.append(item)
          nextPayloads[item] = .staticBanner(banner: banner, sectionTitle: sectionData.title)
        }
        snapshot.appendItems(items, toSection: .staticBanner)
      case .highlightedProduct:
        var items: [CategoryHubItem] = []
        for index in 0..<4 {
          let item = CategoryHubItem.highlightedProduct(index: index)
          items.append(item)
          nextPayloads[item] = .product(categoryName: viewModel.selectedCategoryName, index: index)
        }
        snapshot.appendItems(items, toSection: .highlightedProduct)
      }
    }
    
    return (snapshot, nextPayloads)
  }
  
  // MARK: - Compositional Layout Setup
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
      guard let self else { return nil }
      let snapshot = dataSource.snapshot()
      guard sectionIndex < snapshot.sectionIdentifiers.count else { return nil }
      let sectionType = snapshot.sectionIdentifiers[sectionIndex]
      
      if snapshot.numberOfItems(inSection: sectionType) == 0 {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0.01)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0.01)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero
        return section
      }
      
      switch sectionType {
      case .sliderBanner:
        return createSliderBannerSectionLayout()
      case .textContent:
        return createTextContentSectionLayout()
      case .videoBanner:
        return createVideoBannerSectionLayout()
      case .staticBanner:
        return createStaticBannerSectionLayout()
      case .highlightedProduct:
        return createHighlightedProductSectionLayout()
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

#Preview {
  CategoryHubDiffableViewController()
}
