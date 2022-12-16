//
//  CategoryCollectionViewCell.swift
//  SomeVKCupProject
//
//  Created by Павел Кай on 11.12.2022.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var verticalDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [categoryTitle, verticalDivider, addIcon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(contentStackView)
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        categoryTitle.text = title
    }
    
    func setSelected() {
        backgroundColor = .orange
        verticalDivider.isHidden = true
        addIcon.image = UIImage(systemName: "checkmark")?.withTintColor(.label, renderingMode: .alwaysOriginal)
    }
    
}

extension CategoryCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            verticalDivider.widthAnchor.constraint(equalToConstant: 1),
            verticalDivider.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
