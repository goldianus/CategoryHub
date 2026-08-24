//
//  CMSMockData.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import Foundation

// MARK: - CMS Mock Data Helper
struct CMSMockData {
  
  static func getMockResponse(for categoryName: String = "Brands") -> ContentManagementSystemResponse {
    
    let sliderBanners: [ContentManagementSystemBanner]?
    let textContentText: String?
    let videoTitle: String?
    let staticBanners: [ContentManagementSystemBanner]?
    let highlightedSubtitle: String?
    let hasHighlightedProducts: Bool
    
    switch categoryName.lowercased() {
    case "adidas":
      // Omits Video Section
      sliderBanners = [
        ContentManagementSystemBanner(
          imageTitle: "adidas Ultraboost 5",
          imageCTALink: "https://example.com/adidas-ultraboost",
          imageDeeplink: "app://adidas-ultraboost",
          imageContent: "Kenyamanan maksimal setiap langkah",
          imageFilename: "adidas_ub.jpg",
          imageURL: "https://dummyimage.com/800x400/000/fff&text=adidas+Ultraboost"
        ),
        ContentManagementSystemBanner(
          imageTitle: "adidas Samba OG",
          imageCTALink: "https://example.com/adidas-samba",
          imageDeeplink: "app://adidas-samba",
          imageContent: "Ikon streetwear klasik",
          imageFilename: "adidas_samba.jpg",
          imageURL: "https://dummyimage.com/800x400/333/fff&text=adidas+Samba+OG"
        )
      ]
      textContentText = "Jelajahi produk resmi adidas & adidas Originals. Dapatkan sepatu, pakaian, dan aksesori olahraga terbaik."
      videoTitle = nil // No video section
      staticBanners = [
        ContentManagementSystemBanner(
          imageTitle: "Koleksi Originals",
          imageCTALink: "https://example.com/adidas-originals",
          imageDeeplink: "app://adidas-originals",
          imageContent: "Gaya klasik untuk penampilan sehari-hari",
          imageFilename: "originals_static.jpg",
          imageURL: "https://dummyimage.com/600x300/111/fff&text=adidas+Originals"
        )
      ]
      highlightedSubtitle = "Produk adidas Terpopuler"
      hasHighlightedProducts = true
      
    case "adidas originals":
      // Omits Text & Video sections
      sliderBanners = [
        ContentManagementSystemBanner(
          imageTitle: "adidas Superstar Heritage",
          imageCTALink: "https://example.com/adidas-superstar",
          imageDeeplink: "app://adidas-superstar",
          imageContent: "Shell-toe ikonik sejak 1969",
          imageFilename: "superstar.jpg",
          imageURL: "https://dummyimage.com/800x400/222/fff&text=adidas+Superstar"
        )
      ]
      textContentText = nil // No text section
      videoTitle = nil // No video section
      staticBanners = [
        ContentManagementSystemBanner(
          imageTitle: "Originals Apparel",
          imageCTALink: "https://example.com/originals-apparel",
          imageDeeplink: "app://originals-apparel",
          imageContent: "Jaket Trefoil & Trackpants",
          imageFilename: "apparel.jpg",
          imageURL: "https://dummyimage.com/600x300/444/fff&text=Originals+Apparel"
        )
      ]
      highlightedSubtitle = "Koleksi Trefoil Ikonik"
      hasHighlightedProducts = true
      
    case "asics":
      // Omits Text & Static Banner sections
      sliderBanners = [
        ContentManagementSystemBanner(
          imageTitle: "ASICS GEL-KAYANO 31",
          imageCTALink: "https://example.com/asics-kayano",
          imageDeeplink: "app://asics-kayano",
          imageContent: "Stabilitas luar biasa untuk lari jarak jauh",
          imageFilename: "asics_kayano.jpg",
          imageURL: "https://dummyimage.com/800x400/004d40/fff&text=ASICS+GEL-KAYANO"
        )
      ]
      textContentText = nil // No text section
      videoTitle = "ASICS: Sound Mind, Sound Body"
      staticBanners = nil // No static banner section
      highlightedSubtitle = "Rekomendasi ASICS Running"
      hasHighlightedProducts = true
      
    case "birkenstock":
      // Omits Slider Banner & Video sections
      sliderBanners = nil // No slider section
      textContentText = "Birkenstock menyajikan kenyamanan footbed anatomis khas Jerman. Tradisi footbed sejak 1774 untuk kesehatan kaki Anda."
      videoTitle = nil // No video section
      staticBanners = [
        ContentManagementSystemBanner(
          imageTitle: "Boston Clog Collection",
          imageCTALink: "https://example.com/birkenstock-boston",
          imageDeeplink: "app://birkenstock-boston",
          imageContent: "Gaya kasual yang tak lekang oleh waktu",
          imageFilename: "birkenstock_static.jpg",
          imageURL: "https://dummyimage.com/600x300/3e2723/fff&text=Birkenstock+Boston"
        )
      ]
      highlightedSubtitle = "Sandal Birkenstock Pilihan"
      hasHighlightedProducts = true
      
    case "nike":
      // Omits Static Banner section
      sliderBanners = [
        ContentManagementSystemBanner(
          imageTitle: "Nike Air Max Dn",
          imageCTALink: "https://example.com/nike-dn",
          imageDeeplink: "app://nike-dn",
          imageContent: "Sensasi kenyamanan generasi berikutnya",
          imageFilename: "nike_dn.jpg",
          imageURL: "https://dummyimage.com/800x400/e65100/fff&text=Nike+Air+Max+Dn"
        )
      ]
      textContentText = "Nikmati inovasi performa tinggi dari Nike. Dapatkan koleksi sepatu lari, basket, dan pakaian olahraga berkualitas."
      videoTitle = "Nike: Just Do It"
      staticBanners = nil // No static banner
      highlightedSubtitle = "Pilihan Sepatu Nike Favorit"
      hasHighlightedProducts = true
      
    case "puma":
      // Omits Text Content section
      sliderBanners = [
        ContentManagementSystemBanner(
          imageTitle: "PUMA Palermo",
          imageCTALink: "https://example.com/puma-palermo",
          imageDeeplink: "app://puma-palermo",
          imageContent: "Kembalinya legenda terrace culture",
          imageFilename: "puma_palermo.jpg",
          imageURL: "https://dummyimage.com/800x400/880e4f/fff&text=PUMA+Palermo"
        )
      ]
      textContentText = nil // No text section
      videoTitle = "PUMA: Forever Faster"
      staticBanners = [
        ContentManagementSystemBanner(
          imageTitle: "PUMA Motorsport",
          imageCTALink: "https://example.com/puma-motorsport",
          imageDeeplink: "app://puma-motorsport",
          imageContent: "Koleksi resmi Formula 1 & Racing",
          imageFilename: "puma_static.jpg",
          imageURL: "https://dummyimage.com/600x300/ad1457/fff&text=PUMA+Motorsport"
        )
      ]
      highlightedSubtitle = "Koleksi PUMA Terbaru"
      hasHighlightedProducts = true
      
    default:
      // "Brands": Contains All 5 Sections
      sliderBanners = [
        ContentManagementSystemBanner(
          imageTitle: "Promo Kemerdekaan",
          imageCTALink: "https://example.com/promo1",
          imageDeeplink: "app://promo1",
          imageContent: "Diskon hingga 70%",
          imageFilename: "promo1.jpg",
          imageURL: "https://dummyimage.com/800x400/000/fff&text=Promo+Kemerdekaan"
        ),
        ContentManagementSystemBanner(
          imageTitle: "New Arrival: Brand Showcase",
          imageCTALink: "https://example.com/brands",
          imageDeeplink: "app://brands",
          imageContent: "Koleksi dari berbagai brand ternama",
          imageFilename: "brands.jpg",
          imageURL: "https://dummyimage.com/800x400/ff5722/fff&text=Multibrand+Showcase"
        )
      ]
      textContentText = "Temukan koleksi sepatu olahraga dan apparel pilihan terbaik dari brand global ternama dengan jaminan original 100%."
      videoTitle = "Trending Brand Launch"
      staticBanners = [
        ContentManagementSystemBanner(
          imageTitle: "Gaya Santai",
          imageCTALink: "https://example.com/casual",
          imageDeeplink: "app://casual",
          imageContent: "Koleksi pakaian kasual untuk akhir pekan",
          imageFilename: "casual.jpg",
          imageURL: "https://dummyimage.com/600x300/4caf50/fff&text=Gaya+Santai"
        )
      ]
      highlightedSubtitle = "Rekomendasi Spesial Semua Brand"
      hasHighlightedProducts = true
    }
    
    var mockDataArray: [ContentManagementSystemData] = []
    
    // Index 0: Slider Banner Section
    if let sliderBanners = sliderBanners, !sliderBanners.isEmpty {
      mockDataArray.append(ContentManagementSystemData(
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
        categoryName: categoryName,
        textSubtitle: nil,
        buttonText: nil,
        title: "Highlight \(categoryName)",
        contentTypeCode: "B1",
        videoIsAutoPlay: nil
      ))
    }
    
    // Index 1: Text Content Section
    if let textContentText = textContentText {
      mockDataArray.append(ContentManagementSystemData(
        videoURL: nil,
        videoDeeplink: nil,
        description: nil,
        textContent: textContentText,
        id: 2,
        bannerType: nil,
        buttonURL: nil,
        index: 1,
        categoryID: "cat_01",
        banners: nil,
        contentType: "text",
        categoryName: categoryName,
        textSubtitle: "Tentang \(categoryName)",
        buttonText: "Lihat Selengkapnya",
        title: "Informasi \(categoryName)",
        contentTypeCode: "T1",
        videoIsAutoPlay: nil
      ))
    }
    
    // Index 2: Video Banner Section
    if let videoTitle = videoTitle {
      mockDataArray.append(ContentManagementSystemData(
        videoURL: "https://www.w3schools.com/html/mov_bbb.mp4",
        videoDeeplink: "app://video",
        description: "Tonton video peluncuran produk terbaru.",
        textContent: nil,
        id: 3,
        bannerType: nil,
        buttonURL: "https://example.com/video-detail",
        index: 2,
        categoryID: "cat_02",
        banners: nil,
        contentType: "video",
        categoryName: categoryName,
        textSubtitle: "Exclusive Release",
        buttonText: "Beli Sekarang",
        title: videoTitle,
        contentTypeCode: "V1",
        videoIsAutoPlay: true
      ))
    }
    
    // Index 3: Static Banner Section
    if let staticBanners = staticBanners, !staticBanners.isEmpty {
      mockDataArray.append(ContentManagementSystemData(
        videoURL: nil,
        videoDeeplink: nil,
        description: "Pilihan favorit",
        textContent: nil,
        id: 4,
        bannerType: "static",
        buttonURL: nil,
        index: 3,
        categoryID: "cat_03",
        banners: staticBanners,
        contentType: "banner",
        categoryName: categoryName,
        textSubtitle: nil,
        buttonText: nil,
        title: "Pilihan Editor - \(categoryName)",
        contentTypeCode: "B2",
        videoIsAutoPlay: nil
      ))
    }
    
    // Index 4: Highlighted Product Section
    if hasHighlightedProducts {
      mockDataArray.append(ContentManagementSystemData(
        videoURL: nil,
        videoDeeplink: nil,
        description: "Produk rekomendasi untuk kategori \(categoryName).",
        textContent: nil,
        id: 5,
        bannerType: nil,
        buttonURL: nil,
        index: 4,
        categoryID: "cat_01",
        banners: nil,
        contentType: "highlighted product",
        categoryName: categoryName,
        textSubtitle: highlightedSubtitle,
        buttonText: "Lihat Semua",
        title: "Rekomendasi \(categoryName)",
        contentTypeCode: "H1",
        videoIsAutoPlay: nil
      ))
    }
    
    return ContentManagementSystemResponse(
      errorMessage: nil,
      status: "Success",
      data: mockDataArray
    )
  }
}

