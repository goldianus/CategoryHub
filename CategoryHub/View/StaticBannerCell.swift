//
//  StaticBannerCell.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import UIKit
import SnapKit

final class StaticBannerCell: UICollectionViewCell {
  static let reuseIdentifier = "StaticBannerCell"
  
  private let placeholderImageView: UIImageView = {
    let imgView = UIImageView()
    imgView.backgroundColor = .systemTeal
    imgView.contentMode = .scaleAspectFill
    imgView.clipsToBounds = true
    imgView.layer.cornerRadius = 8
    return imgView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.textColor = .white
    return label
  }()
  
  private let shimmerView = ShimmerView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(placeholderImageView)
    placeholderImageView.addSubview(titleLabel)
    contentView.addSubview(shimmerView)
    
    placeholderImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview().inset(12)
    }
    
    shimmerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  func configure(with banner: ContentManagementSystemBanner?, sectionTitle: String?) {
    titleLabel.text = banner?.imageTitle ?? sectionTitle ?? "Static Banner"
  }
  
  func showShimmer(_ show: Bool) {
    if show {
      shimmerView.startAnimating()
    } else {
      shimmerView.stopAnimating()
    }
  }
}
