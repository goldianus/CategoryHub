//
//  FetchCategorySectionsUseCase.swift
//  CategoryHub
//
//  Created by Goldianus SM on 25/08/26.
//

import Foundation

protocol FetchCategorySectionsUseCase {
  func execute(categoryName: String) async throws -> [ContentManagementSystemData]
}

final class DefaultFetchCategorySectionsUseCase: FetchCategorySectionsUseCase {
  private let repository: CategoryRepository
  
  init(repository: CategoryRepository) {
    self.repository = repository
  }
  
  func execute(categoryName: String) async throws -> [ContentManagementSystemData] {
    try await repository.fetchCategorySections(for: categoryName)
  }
}
