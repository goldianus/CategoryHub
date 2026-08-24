//
//  ContentManagementSystemData.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import Foundation

// MARK: - Section Identifier
enum Section: Int, CaseIterable {
  case sliderBanner
  case textContent
  case videoBanner
  case staticBanner
  case highlightedProduct
}

// MARK: - ContentManagementSystemResponse
public struct ContentManagementSystemResponse: Codable, Hashable {
  public let errorMessage: String?
  public let status: String?
  public let data: [ContentManagementSystemData]?
  
  public enum CodingKeys: String, CodingKey {
    case errorMessage = "ErrorMessage"
    case status = "Status"
    case data = "Data"
  }
  
  public init(errorMessage: String?, status: String?, data: [ContentManagementSystemData]?) {
    self.errorMessage = errorMessage
    self.status = status
    self.data = data
  }
}

// MARK: - ContentManagementSystemData
public struct ContentManagementSystemData: Codable, Hashable {
  public let videoURL: String?
  public let videoDeeplink: String?
  public let description: String?
  public let textContent: String?
  public let id: Int?
  public let bannerType: String?
  public let buttonURL: String?
  public let index: Int?
  public let categoryID: String?
  public let banners: [ContentManagementSystemBanner]?
  public let contentType: String?
  public let categoryName: String?
  public let textSubtitle: String?
  public let buttonText: String?
  public let title: String?
  public let contentTypeCode: String?
  public let videoIsAutoPlay: Bool?
  
  public enum CodingKeys: String, CodingKey {
    case videoURL = "VideoURL"
    case videoDeeplink = "VideoDeeplink"
    case description = "Description"
    case textContent = "TextContent"
    case id = "Id"
    case bannerType = "BannerType"
    case buttonURL = "ButtonURL"
    case index = "Index"
    case categoryID = "CategoryId"
    case banners = "Banners"
    case contentType = "ContentType"
    case categoryName = "CategoryName"
    case textSubtitle = "TextSubtitle"
    case buttonText = "ButtonText"
    case title = "Title"
    case contentTypeCode = "ContentTypeCode"
    case videoIsAutoPlay = "VideoIsAutoPlay"
  }
  
  public init(
    videoURL: String?,
    videoDeeplink: String?,
    description: String?,
    textContent: String?,
    id: Int?,
    bannerType: String?,
    buttonURL: String?,
    index: Int?,
    categoryID: String?,
    banners: [ContentManagementSystemBanner]?,
    contentType: String?,
    categoryName: String?,
    textSubtitle: String?,
    buttonText: String?,
    title: String?,
    contentTypeCode: String?,
    videoIsAutoPlay: Bool?
  ) {
    self.videoURL = videoURL
    self.videoDeeplink = videoDeeplink
    self.description = description
    self.textContent = textContent
    self.id = id
    self.bannerType = bannerType
    self.buttonURL = buttonURL
    self.index = index
    self.categoryID = categoryID
    self.banners = banners
    self.contentType = contentType
    self.categoryName = categoryName
    self.textSubtitle = textSubtitle
    self.buttonText = buttonText
    self.title = title
    self.contentTypeCode = contentTypeCode
    self.videoIsAutoPlay = videoIsAutoPlay
  }
}

// MARK: - ContentManagementSystemBanner
public struct ContentManagementSystemBanner: Codable, Hashable {
  public let imageTitle: String?
  public let imageCTALink: String?
  public let imageDeeplink: String?
  public let imageContent: String?
  public let imageFilename: String?
  public let imageURL: String?
  
  public enum CodingKeys: String, CodingKey {
    case imageTitle = "ImageTitle"
    case imageCTALink = "ImageCTALink"
    case imageDeeplink = "ImageDeeplink"
    case imageContent = "ImageContent"
    case imageFilename = "ImageFilename"
    case imageURL = "ImageURL"
  }
  
  public init(
    imageTitle: String?,
    imageCTALink: String?,
    imageDeeplink: String?,
    imageContent: String?,
    imageFilename: String?,
    imageURL: String?
  ) {
    self.imageTitle = imageTitle
    self.imageCTALink = imageCTALink
    self.imageDeeplink = imageDeeplink
    self.imageContent = imageContent
    self.imageFilename = imageFilename
    self.imageURL = imageURL
  }
}
