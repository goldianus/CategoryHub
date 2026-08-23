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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(placeholderImageView)
    placeholderImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
