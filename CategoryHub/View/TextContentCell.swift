//
//  TextContentCell.swift
//  CategoryHub
//
//  Created by Goldianus SM on 23/08/26.
//

import UIKit
import SnapKit

final class TextContentCell: UICollectionViewCell {
  static let reuseIdentifier = "TextContentCell"
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.textColor = .label
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.textColor = .secondaryLabel
    label.numberOfLines = 0
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
    stack.axis = .vertical
    stack.spacing = 8
    
    contentView.addSubview(stack)
    stack.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(16)
    }
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  func configure(title: String?, textContent: String?) {
    titleLabel.text = title
    descriptionLabel.text = textContent
  }
}
