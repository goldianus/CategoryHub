//
//  VideoBannerCell.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import UIKit
import SnapKit

final class VideoBannerCell: UICollectionViewCell {
  static let reuseIdentifier = "VideoBannerCell"
  
  private let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemCyan
    view.layer.cornerRadius = 12
    return view
  }()
  
  private let playIcon: UIImageView = {
    let imgView = UIImageView(image: UIImage(systemName: "play.circle.fill"))
    imgView.tintColor = .white
    return imgView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(containerView)
    containerView.addSubview(playIcon)
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    playIcon.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.size.equalTo(48)
    }
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
