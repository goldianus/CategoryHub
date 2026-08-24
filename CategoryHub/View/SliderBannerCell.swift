//
//  SliderBannerCell.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import UIKit
import SnapKit

final class SliderBannerCell: UICollectionViewCell {
  static let reuseIdentifier = "SliderBannerCell"
  
  private let placeholderImageView: UIImageView = {
    let imgView = UIImageView()
    imgView.backgroundColor = .systemGray4
    imgView.contentMode = .scaleAspectFill
    imgView.clipsToBounds = true
    imgView.layer.cornerRadius = 8
    return imgView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.textColor = .white
    label.numberOfLines = 0
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
  
  func configure(with banner: ContentManagementSystemBanner?) {
    titleLabel.text = banner?.imageTitle ?? banner?.imageContent
  }
  
  func showShimmer(_ show: Bool) {
    if show {
      shimmerView.startAnimating()
    } else {
      shimmerView.stopAnimating()
    }
  }
}
