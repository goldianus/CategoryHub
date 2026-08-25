//
//  CategoryHubViewModel.swift
//  CategoryHub
//
//  Created by Goldianus SM on 24/08/26.
//

import Foundation
import Combine

@MainActor
final class CategoryHubViewModel {
  
  // MARK: - Dependencies (Use Cases)
  private let fetchCategoriesUseCase: FetchCategoriesUseCase
  private let fetchCategorySectionsUseCase: FetchCategorySectionsUseCase
  
  // MARK: - Properties
  @Published private(set) var categories: [String] = []
  @Published private(set) var selectedCategoryIndex: Int = 0
  @Published private(set) var sectionsData: [ContentManagementSystemData] = []
  @Published private(set) var isLoading: Bool = false
  
  private var fetchTask: Task<Void, Never>?
  
  var selectedCategoryName: String {
    guard selectedCategoryIndex >= 0 && selectedCategoryIndex < categories.count else {
      return categories.first ?? ""
    }
    return categories[selectedCategoryIndex]
  }
  
  // MARK: - Init
  init(
    fetchCategoriesUseCase: FetchCategoriesUseCase? = nil,
    fetchCategorySectionsUseCase: FetchCategorySectionsUseCase? = nil
  ) {
    let repository = CMSCategoryRepository()
    self.fetchCategoriesUseCase = fetchCategoriesUseCase ?? DefaultFetchCategoriesUseCase(repository: repository)
    self.fetchCategorySectionsUseCase = fetchCategorySectionsUseCase ?? DefaultFetchCategorySectionsUseCase(repository: repository)
    
    loadInitialData()
  }
  
  // MARK: - Public Methods
  func selectCategory(at index: Int) {
    guard index >= 0 && index < categories.count, index != selectedCategoryIndex else { return }
    selectedCategoryIndex = index
    let categoryName = categories[index]
    fetchData(for: categoryName)
  }
  
  func fetchData(for categoryName: String) {
    fetchTask?.cancel()
    
    isLoading = true
    sectionsData = []
    
    fetchTask = Task { [weak self] in
      guard let self = self else { return }
      do {
        let sections = try await self.fetchCategorySectionsUseCase.execute(categoryName: categoryName)
        guard !Task.isCancelled else { return }
        self.sectionsData = sections
        self.isLoading = false
      } catch {
        guard !Task.isCancelled else { return }
        self.sectionsData = []
        self.isLoading = false
      }
    }
  }
  
  private func loadInitialData() {
    Task { [weak self] in
      guard let self = self else { return }
      do {
        let categoriesList = try await self.fetchCategoriesUseCase.execute()
        self.categories = categoriesList
        if let initialCategory = categoriesList.first {
          self.fetchData(for: initialCategory)
        }
      } catch {
        self.categories = []
      }
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
