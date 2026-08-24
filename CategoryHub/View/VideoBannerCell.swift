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
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(containerView)
    containerView.addSubview(playIcon)
    containerView.addSubview(titleLabel)
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    playIcon.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.size.equalTo(48)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(playIcon.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  func configure(title: String?, description: String?) {
    titleLabel.text = title ?? description
  }
}
