//
//  CategoryHubViewModel.swift
//  CategoryHub
//
//  Created by Goldianus SM on 24/08/26.
//

import Foundation
import Combine

final class CategoryHubViewModel {
  
  // MARK: - Properties
  @Published private(set) var categories: [String] = [
    "Brands",
    "adidas",
    "adidas Originals",
    "Asics",
    "Birkenstock",
    "Nike",
    "Puma"
  ]
  
  @Published private(set) var selectedCategoryIndex: Int = 0
  @Published private(set) var sectionsData: [ContentManagementSystemData] = []
  @Published private(set) var isLoading: Bool = false
  
  var selectedCategoryName: String {
    guard selectedCategoryIndex >= 0 && selectedCategoryIndex < categories.count else {
      return categories.first ?? ""
    }
    return categories[selectedCategoryIndex]
  }
  
  // MARK: - Init
  init() {
    fetchData(for: categories.first ?? "Brands")
  }
  
  // MARK: - Public Methods
  func selectCategory(at index: Int) {
    guard index >= 0 && index < categories.count, index != selectedCategoryIndex else { return }
    selectedCategoryIndex = index
    let categoryName = categories[index]
    fetchData(for: categoryName)
  }
  
  func fetchData(for categoryName: String) {
    isLoading = true
    sectionsData = []
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
      guard let self = self else { return }
      let response = CMSMockData.getMockResponse(for: categoryName)
      self.sectionsData = response.data ?? []
      self.isLoading = false
    }
  }
  
  // MARK: - Data Helpers for Section
  func sectionData(at sectionIndex: Int) -> ContentManagementSystemData? {
    return sectionsData.first(where: { $0.index == sectionIndex })
  }
  
  func numberOfItems(at sectionIndex: Int) -> Int {
    if isLoading {
      switch sectionIndex {
      case 0: return 2
      case 1: return 1
      case 2: return 1
      case 3: return 1
      case 4: return 4
      default: return 0
      }
    }
    
    guard let data = sectionData(at: sectionIndex) else { return 0 }
    switch sectionIndex {
    case 0:
      return data.banners?.count ?? 0
    case 1:
      return data.textContent != nil ? 1 : 0
    case 2:
      return data.videoURL != nil ? 1 : 0
    case 3:
      return data.banners?.count ?? 0
    case 4:
      return 4
    default:
      return 0
    }
  }
}
