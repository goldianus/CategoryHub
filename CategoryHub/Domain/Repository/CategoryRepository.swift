//
//  CategoryRepository.swift
//  CategoryHub
//
//  Created by Goldianus SM on 25/08/26.
//

import Foundation

protocol CategoryRepository {
  func fetchCategories() async throws -> [String]
  func fetchCategorySections(for categoryName: String) async throws -> [ContentManagementSystemData]
}
