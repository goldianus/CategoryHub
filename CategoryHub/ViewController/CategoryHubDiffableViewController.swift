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

// MARK: - Diffable Data Source Item Definition
nonisolated enum CategoryHubItem: Hashable, Sendable {
  case sliderBanner(ContentManagementSystemBanner)
  case textContent(title: String?, textContent: String?)
  case videoBanner(title: String?, description: String?)
  case staticBanner(banner: ContentManagementSystemBanner, sectionTitle: String?)
  case highlightedProduct(categoryName: String, itemIndex: Int)
  case skeleton(section: Section, index: Int)
}

// MARK: - CategoryHubDiffableViewController Implementation
@MainActor
final class CategoryHubDiffableViewController: UIViewController {
  
  private let categoryHeaderView = CategoryHeaderView()
  private let viewModel = CategoryHubViewModel()
  private var cancellables = Set<AnyCancellable>()
  
  private lazy var dataSource: UICollectionViewDiffableDataSource<Section, CategoryHubItem> = makeDataSource()
  
  private lazy var collectionView: UICollectionView = {
    let layout = createCompositionalLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemGroupedBackground
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
  
  // MARK: - UICollectionViewDiffableDataSource Configuration
  private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, CategoryHubItem> {
    return UICollectionViewDiffableDataSource<Section, CategoryHubItem>(collectionView: collectionView) { collectionView, indexPath, item in
      switch item {
      case .skeleton(let section, _):
        switch section {
        case .sliderBanner:
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderBannerCell.reuseIdentifier, for: indexPath) as? SliderBannerCell
          cell?.showShimmer(true)
          return cell ?? UICollectionViewCell()
        case .textContent:
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextContentCell.reuseIdentifier, for: indexPath) as? TextContentCell
          cell?.showShimmer(true)
          return cell ?? UICollectionViewCell()
        case .videoBanner:
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoBannerCell.reuseIdentifier, for: indexPath) as? VideoBannerCell
          cell?.showShimmer(true)
          return cell ?? UICollectionViewCell()
        case .staticBanner:
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBannerCell.reuseIdentifier, for: indexPath) as? StaticBannerCell
          cell?.showShimmer(true)
          return cell ?? UICollectionViewCell()
        case .highlightedProduct:
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HighlightedProductCell.reuseIdentifier, for: indexPath) as? HighlightedProductCell
          cell?.showShimmer(true)
          return cell ?? UICollectionViewCell()
        }
        
      case .sliderBanner(let banner):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderBannerCell.reuseIdentifier, for: indexPath) as? SliderBannerCell else {
          return UICollectionViewCell()
        }
        cell.showShimmer(false)
        cell.configure(with: banner)
        return cell

      case .textContent(let title, let content):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextContentCell.reuseIdentifier, for: indexPath) as? TextContentCell else {
          return UICollectionViewCell()
        }
        cell.showShimmer(false)
        cell.configure(title: title, textContent: content)
        return cell

      case .videoBanner(let title, let description):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoBannerCell.reuseIdentifier, for: indexPath) as? VideoBannerCell else {
          return UICollectionViewCell()
        }
        cell.showShimmer(false)
        cell.configure(title: title, description: description)
        return cell

      case .staticBanner(let banner, let sectionTitle):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBannerCell.reuseIdentifier, for: indexPath) as? StaticBannerCell else {
          return UICollectionViewCell()
        }
        cell.showShimmer(false)
        cell.configure(with: banner, sectionTitle: sectionTitle)
        return cell

      case .highlightedProduct(let categoryName, let itemIndex):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HighlightedProductCell.reuseIdentifier, for: indexPath) as? HighlightedProductCell else {
          return UICollectionViewCell()
        }
        cell.showShimmer(false)
        cell.configure(categoryName: categoryName, itemIndex: itemIndex)
        return cell
      }
    }
  }
  
  // MARK: - Snapshot Application
  private func applySnapshot(animatingDifferences: Bool = true) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, CategoryHubItem>()
    snapshot.appendSections(Section.allCases)
    
    if viewModel.isLoading {
      snapshot.appendItems((0..<2).map { CategoryHubItem.skeleton(section: .sliderBanner, index: $0) }, toSection: Section.sliderBanner)
      snapshot.appendItems([CategoryHubItem.skeleton(section: .textContent, index: 0)], toSection: Section.textContent)
      snapshot.appendItems([CategoryHubItem.skeleton(section: .videoBanner, index: 0)], toSection: Section.videoBanner)
      snapshot.appendItems([CategoryHubItem.skeleton(section: .staticBanner, index: 0)], toSection: Section.staticBanner)
      snapshot.appendItems((0..<4).map { CategoryHubItem.skeleton(section: .highlightedProduct, index: $0) }, toSection: Section.highlightedProduct)
    } else {
      for section in Section.allCases {
        guard let sectionData = viewModel.sectionData(at: section.rawValue) else { continue }
        switch section {
        case .sliderBanner:
          if let banners = sectionData.banners {
            let items = banners.map { CategoryHubItem.sliderBanner($0) }
            snapshot.appendItems(items, toSection: Section.sliderBanner)
          }
        case .textContent:
          if sectionData.textContent != nil {
            snapshot.appendItems([CategoryHubItem.textContent(title: sectionData.title, textContent: sectionData.textContent)], toSection: Section.textContent)
          }
        case .videoBanner:
          if sectionData.videoURL != nil {
            snapshot.appendItems([CategoryHubItem.videoBanner(title: sectionData.title, description: sectionData.description)], toSection: Section.videoBanner)
          }
        case .staticBanner:
          if let banners = sectionData.banners {
            let items = banners.map { CategoryHubItem.staticBanner(banner: $0, sectionTitle: sectionData.title) }
            snapshot.appendItems(items, toSection: Section.staticBanner)
          }
        case .highlightedProduct:
          let items = (0..<4).map { CategoryHubItem.highlightedProduct(categoryName: viewModel.selectedCategoryName, itemIndex: $0) }
          snapshot.appendItems(items, toSection: Section.highlightedProduct)
        }
      }
    }
    
    dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
  }
  
  // MARK: - Compositional Layout Setup
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
      guard let self = self, let sectionType = Section(rawValue: sectionIndex) else { return nil }
      
      let snapshot = self.dataSource.snapshot()
      let itemCount = snapshot.numberOfItems(inSection: sectionType)
      
      if itemCount == 0 {
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

#Preview {
  CategoryHubDiffableViewController()
}
