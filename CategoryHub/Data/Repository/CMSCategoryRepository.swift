//
//  CMSCategoryRepository.swift
//  CategoryHub
//
//  Created by Goldianus SM on 25/08/26.
//

import Foundation

final class CMSCategoryRepository: CategoryRepository {
  func fetchCategories() async throws -> [String] {
    return [
      "Brands",
      "adidas",
      "adidas Originals",
      "Asics",
      "Birkenstock",
      "Nike",
      "Puma"
    ]
  }
  
  func fetchCategorySections(for categoryName: String) async throws -> [ContentManagementSystemData] {
    try await Task.sleep(nanoseconds: 2_000_000_000)
    let response = CMSMockData.getMockResponse(for: categoryName)
    return response.data ?? []
  }
}
