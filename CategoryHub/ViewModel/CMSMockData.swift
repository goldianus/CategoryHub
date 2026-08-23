//
//  CMSMockData.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import Foundation

// MARK: - CMS Mock Data Helper
struct CMSMockData {
  
  static func getMockResponse() -> ContentManagementSystemResponse {
    
    let sliderBanners = [
      ContentManagementSystemBanner(
        imageTitle: "Promo Kemerdekaan",
        imageCTALink: "https://example.com/promo1",
        imageDeeplink: "app://promo1",
        imageContent: "Diskon hingga 70%",
        imageFilename: "promo1.jpg",
        imageURL: "https://dummyimage.com/800x400/000/fff&text=Promo+Kemerdekaan"
      ),
      ContentManagementSystemBanner(
        imageTitle: "New Arrival: Nike Air",
        imageCTALink: "https://example.com/nike",
        imageDeeplink: "app://nike",
        imageContent: "Koleksi terbaru dari Nike",
        imageFilename: "nike_air.jpg",
        imageURL: "https://dummyimage.com/800x400/ff5722/fff&text=New+Arrival+Nike"
      )
    ]
    
    let sliderSection = ContentManagementSystemData(
      videoURL: nil,
      videoDeeplink: nil,
      description: "Carousel promo terbaru",
      textContent: nil,
      id: 1,
      bannerType: "slider",
      buttonURL: nil,
      index: 0,
      categoryID: "cat_01",
      banners: sliderBanners,
      contentType: "banner",
      categoryName: "Home Promo",
      textSubtitle: nil,
      buttonText: nil,
      title: "Highlight Promo",
      contentTypeCode: "B1",
      videoIsAutoPlay: nil
    )
    
    let textSection = ContentManagementSystemData(
      videoURL: nil,
      videoDeeplink: nil,
      description: nil,
      textContent: "Temukan koleksi sepatu olahraga dan apparel pilihan terbaik untuk menemani aktivitas harian dan olahragamu. Tersedia brand global ternama dengan jaminan original 100%.",
      id: 2,
      bannerType: nil,
      buttonURL: nil,
      index: 1,
      categoryID: "cat_01",
      banners: nil,
      contentType: "text",
      categoryName: "Home Info",
      textSubtitle: "Koleksi Terbaik Tahun Ini",
      buttonText: "Lihat Semua",
      title: "Informasi",
      contentTypeCode: "T1",
      videoIsAutoPlay: nil
    )
    
    let videoSection = ContentManagementSystemData(
      videoURL: "https://www.w3schools.com/html/mov_bbb.mp4",
      videoDeeplink: "app://video",
      description: "Tonton video peluncuran seri sepatu paling ikonik tahun ini.",
      textContent: nil,
      id: 3,
      bannerType: nil,
      buttonURL: "https://example.com/video-detail",
      index: 2,
      categoryID: "cat_02",
      banners: nil,
      contentType: "video",
      categoryName: "Lifestyle",
      textSubtitle: "Exclusive Release",
      buttonText: "Beli Sekarang",
      title: "Trending Sekarang",
      contentTypeCode: "V1",
      videoIsAutoPlay: true
    )
    
    let staticBanners = [
      ContentManagementSystemBanner(
        imageTitle: "Gaya Santai",
        imageCTALink: "https://example.com/casual",
        imageDeeplink: "app://casual",
        imageContent: "Koleksi pakaian kasual untuk akhir pekan",
        imageFilename: "casual.jpg",
        imageURL: "https://dummyimage.com/600x300/4caf50/fff&text=Gaya+Santai"
      )
    ]
    
    let staticBannerSection = ContentManagementSystemData(
      videoURL: nil,
      videoDeeplink: nil,
      description: "Pilihan santai Anda",
      textContent: nil,
      id: 4,
      bannerType: "static",
      buttonURL: nil,
      index: 3,
      categoryID: "cat_03",
      banners: staticBanners,
      contentType: "banner",
      categoryName: "Fashion",
      textSubtitle: nil,
      buttonText: nil,
      title: "Pilihan Editor",
      contentTypeCode: "B2",
      videoIsAutoPlay: nil
    )
    
    let highlightedProductSection = ContentManagementSystemData(
      videoURL: nil,
      videoDeeplink: nil,
      description: "Produk rekomendasi spesial untuk Anda.",
      textContent: nil,
      id: 5,
      bannerType: nil,
      buttonURL: nil,
      index: 4,
      categoryID: "cat_01",
      banners: nil,
      contentType: "highlighted product",
      categoryName: "Home Promo",
      textSubtitle: "Berdasarkan histori pencarian",
      buttonText: "Lihat Semua",
      title: "Rekomendasi Spesial",
      contentTypeCode: "H1",
      videoIsAutoPlay: nil
    )
    
    let mockDataArray = [
      sliderSection,
      textSection,
      videoSection,
      staticBannerSection,
      highlightedProductSection
    ]
    
    return ContentManagementSystemResponse(
      errorMessage: nil,
      status: "Success",
      data: mockDataArray
    )
  }
}
