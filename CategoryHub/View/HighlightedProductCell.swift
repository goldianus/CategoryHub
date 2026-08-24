//
//  HighlightedProductCell.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import UIKit
import SnapKit

final class HighlightedProductCell: UICollectionViewCell {
  static let reuseIdentifier = "HighlightedProductCell"
  
  private let imageView: UIImageView = {
    let imgView = UIImageView()
    imgView.backgroundColor = .systemPink
    imgView.layer.cornerRadius = 8
    return imgView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Product Name"
    label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.text = "Rp 1.000.000"
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.textColor = .secondaryLabel
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .systemBackground
    contentView.layer.cornerRadius = 8
    
    let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, priceLabel])
    stack.axis = .vertical
    stack.spacing = 6
    
    contentView.addSubview(stack)
    stack.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(8)
    }
    
    imageView.snp.makeConstraints { make in
      make.height.equalTo(100)
    }
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  func configure(categoryName: String, itemIndex: Int) {
    titleLabel.text = "\(categoryName) Item #\(itemIndex + 1)"
    priceLabel.text = "Rp \((itemIndex + 1) * 250).000"
  }
}
