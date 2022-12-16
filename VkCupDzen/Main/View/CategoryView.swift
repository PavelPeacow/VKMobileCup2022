//
//  CategoryView.swift
//  SomeVKCupProject
//
//  Created by Павел Кай on 11.12.2022.
//

import UIKit

final class CategoryView: UIView {
    
    lazy var categoriesDescription: UILabel = {
        let label = UILabel()
        label.text = "Отметьте то, что вам интересно, чтобы настроить Дзен"
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var laterBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGray6
        btn.setTitle("Позже", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    lazy var categoriesDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [categoriesDescription, laterBtn])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var collectionViewDefaultCategories: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(section: .createCategorySection())
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    lazy var horizontalDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionViewSelectedCategories: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(section: .createCategorySection())
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.setEmptyMessageInCollectionView("Выбранные категории будут отображаться здесь😉", .headline)
        
        return collectionView
    }()
    
    lazy var collectionsCategoriesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [collectionViewDefaultCategories, collectionViewSelectedCategories])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 24
        stackView.axis = .vertical
        return stackView
    }()
        
    lazy var continueBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .label
        btn.setTitleColor(.systemBackground, for: .normal)
        btn.setTitle("Продолжить", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 30
        btn.alpha = 0.0
        return btn
    }()
    
    lazy var setDefaultCategoriesBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        
        let image = UIImage(systemName: "x.circle", withConfiguration: config)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        btn.setImage(image, for: .normal)
        
        btn.alpha = 0.0
        return btn
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [setDefaultCategoriesBtn, continueBtn])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.axis = .horizontal
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [categoriesDescriptionStackView, horizontalDivider, collectionsCategoriesStackView, buttonsStackView]
            .forEach {
                addSubview($0)
            }
    }
    
}

extension CategoryView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoriesDescriptionStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            categoriesDescriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoriesDescriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            laterBtn.heightAnchor.constraint(equalToConstant: 40),
            laterBtn.widthAnchor.constraint(equalToConstant: 80),
            
            collectionsCategoriesStackView.topAnchor.constraint(equalTo: categoriesDescriptionStackView.bottomAnchor, constant: 20),
            collectionsCategoriesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionsCategoriesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionsCategoriesStackView.bottomAnchor.constraint(equalTo: continueBtn.topAnchor, constant: -16),
            
            horizontalDivider.centerXAnchor.constraint(equalTo: centerXAnchor),
            horizontalDivider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            horizontalDivider.topAnchor.constraint(equalTo: collectionViewDefaultCategories.bottomAnchor, constant: 12),
            horizontalDivider.heightAnchor.constraint(equalToConstant: 1),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            setDefaultCategoriesBtn.heightAnchor.constraint(equalToConstant: 60),
            setDefaultCategoriesBtn.widthAnchor.constraint(equalToConstant: 60),
            
            continueBtn.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
