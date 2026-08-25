//
//  FetchCategoriesUseCase.swift
//  CategoryHub
//
//  Created by Goldianus SM on 25/08/26.
//

import Foundation

protocol FetchCategoriesUseCase {
  func execute() async throws -> [String]
}

final class DefaultFetchCategoriesUseCase: FetchCategoriesUseCase {
  private let repository: CategoryRepository
  
  init(repository: CategoryRepository) {
    self.repository = repository
  }
  
  func execute() async throws -> [String] {
    try await repository.fetchCategories()
  }
}
