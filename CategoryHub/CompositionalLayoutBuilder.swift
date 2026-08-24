//
//  CompositionalLayoutBuilder.swift
//  CategoryHub
//
//  Created by Goldianus SM on 24/08/26.
//

import UIKit

public struct CompositionalLayoutBuilder {
  private static let defaultLayoutSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(1.0),
    heightDimension: .estimated(1000)
  )
  
  private var itemLayoutSize = CompositionalLayoutBuilder.defaultLayoutSize
  private var itemInsets: NSDirectionalEdgeInsets = .zero
  
  private var groupLayoutSize = CompositionalLayoutBuilder.defaultLayoutSize
  
  private var sectionInterGroupSpacing: CGFloat = 0
  private var sectionInsets: NSDirectionalEdgeInsets = .zero
  private var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
  
  public init() { }
  
  public func withItemLayoutSize(_ size: NSCollectionLayoutSize) -> Self {
    var builder = self
    builder.itemLayoutSize = size
    return builder
  }
  
  public func withItemInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
    var builder = self
    builder.itemInsets = insets
    return builder
  }
  
  public func withGroupLayoutSize(_ size: NSCollectionLayoutSize) -> Self {
    var builder = self
    builder.groupLayoutSize = size
    return builder
  }
  
  public func withSectionInterGroupSpacing(_ spacing: CGFloat) -> Self {
    var builder = self
    builder.sectionInterGroupSpacing = spacing
    return builder
  }
  
  public func withSectionInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
    var builder = self
    builder.sectionInsets = insets
    return builder
  }
  
  public func withOrthogonalScrollingBehavior(_ behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> Self {
    var builder = self
    builder.orthogonalScrollingBehavior = behavior
    return builder
  }
  
  public func build() -> NSCollectionLayoutSection {
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [makeItem()])
    return makeSection(with: group)
  }
  
  public func build(repeatingSubItemCount: Int) -> NSCollectionLayoutSection {
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupLayoutSize,
      repeatingSubitem: makeItem(),
      count: repeatingSubItemCount
    )
    return makeSection(with: group)
  }
  
  // MARK: - Private Helpers
  private func makeItem() -> NSCollectionLayoutItem {
    let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
    item.contentInsets = itemInsets
    return item
  }
  
  private func makeSection(with group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = sectionInsets
    section.interGroupSpacing = sectionInterGroupSpacing
    section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
    return section
  }
}
