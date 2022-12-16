//
//  CategoryViewController.swift
//  SomeVKCupProject
//
//  Created by Павел Кай on 11.12.2022.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    //MARK: Properties
    let categoryView = CategoryView()
    
    var categoryModel = CategoryModel() {
        didSet {
            animateContinueBtnAppear()
            setEmptyMessage(dataSource: categoryModel.selectedCategories, message: "Выбранные категории будут отображаться здесь😉", in: categoryView.collectionViewSelectedCategories)
            setEmptyMessage(dataSource: categoryModel.categories, message: "Вы выбрали все категории!😎", in: categoryView.collectionViewDefaultCategories)
        }
    }
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        setTargets()
        setDelegates()
    }
    
    override func loadView() {
        super.loadView()
        view = categoryView
    }
    
    //MARK: Functions
    private func setDelegates() {
        categoryView.collectionViewDefaultCategories.dataSource = self
        categoryView.collectionViewDefaultCategories.delegate = self
        categoryView.collectionViewSelectedCategories.dataSource = self
        categoryView.collectionViewSelectedCategories.delegate = self
    }
    
    private func animateContinueBtnAppear() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            
            if !self.categoryModel.selectedCategories.isEmpty {
                self.categoryView.continueBtn.alpha = 1.0
                self.categoryView.setDefaultCategoriesBtn.alpha = 1.0
            }
            else {
                self.categoryView.continueBtn.alpha = 0.0
                self.categoryView.setDefaultCategoriesBtn.alpha = 0.0
            }
        }
    }
    
    private func setEmptyMessage(dataSource: [CategoryModel.Category], message: String, in collectionView: UICollectionView) {
        if dataSource.isEmpty { collectionView.setEmptyMessageInCollectionView(message, .headline)}
        else { collectionView.backgroundView = nil }
    }
    
    private func setTargets() {
        categoryView.setDefaultCategoriesBtn.addTarget(self, action: #selector(didTapSetDefaultCategoriesBtn), for: .touchUpInside)
        categoryView.continueBtn.addTarget(self, action: #selector(didTapContinueBtn), for: .touchUpInside)
    }
    
}

//MARK: Selector
extension CategoryViewController {
    
    @objc func didTapSetDefaultCategoriesBtn(_ sender: UIButton) {
        sender.animateTapOnButton()
        
        let ac = UIAlertController(title: "Вы хотите сбросить выбранные категории?", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.categoryModel.resetCategories()
            
            self.categoryView.collectionViewDefaultCategories.reloadData()
            self.categoryView.collectionViewSelectedCategories.reloadData()
            
            let startOfCollection = IndexPath(row: 0, section: 0)
            self.categoryView.collectionViewDefaultCategories.scrollToItem(at: startOfCollection, at: .top, animated: true)
        }
        let actionCancel = UIAlertAction(title: "Нет", style: .cancel)
        
        ac.addAction(action)
        ac.addAction(actionCancel)
        
        present(ac, animated: true)
    }
    
    @objc func didTapContinueBtn(_ sender: UIButton) {
        sender.animateTapOnButton()
        let message = categoryModel.showAllSelectedCategories()
        
        let ac = UIAlertController(title: "Выбранные категории", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }
    
}

//MARK: Datasource
extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryView.collectionViewDefaultCategories:
            return categoryModel.categories.count
        case categoryView.collectionViewSelectedCategories:
            return categoryModel.selectedCategories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        switch collectionView {
        case categoryView.collectionViewDefaultCategories:
            cell.configure(with: categoryModel.categories[indexPath.row].categoryName)
        case categoryView.collectionViewSelectedCategories:
            cell.configure(with: categoryModel.selectedCategories[indexPath.row].categoryName)
            cell.setSelected()
        default:
            return UICollectionViewCell()
        }
        
        return cell
    }
    
}

//MARK: Delegate
extension CategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.25) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
    
    //MARK: Moving categories
    func moveCategoryToSelectedCategoriesCollection(indexPath: IndexPath) {
        let startOfCollection = IndexPath(row: 0, section: 0)
        
        categoryModel.setCategorySelected(which: indexPath.row)
        
        categoryView.collectionViewSelectedCategories.performBatchUpdates({ [weak self] in
            guard let self = self else { return }
            self.categoryView.collectionViewSelectedCategories.insertItems(at: [startOfCollection])
            self.categoryView.collectionViewDefaultCategories.deleteItems(at: [indexPath])
        })
        
        categoryView.collectionViewSelectedCategories.scrollToItem(at: startOfCollection, at: .top, animated: true)
    }
    
    
    func moveItemToDefaultCategoriesCollection(indexPath: IndexPath) {
        let startOfCollection = IndexPath(row: 0, section: 0)
        
        categoryModel.setCategoryDeselected(which: indexPath.row)
        
        categoryView.collectionViewDefaultCategories.performBatchUpdates({ [weak self] in
            guard let self = self else { return }
            self.categoryView.collectionViewDefaultCategories.insertItems(at: [startOfCollection])
            self.categoryView.collectionViewSelectedCategories.deleteItems(at: [indexPath])
        })
        
        categoryView.collectionViewDefaultCategories.scrollToItem(at: startOfCollection, at: .top, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoryView.collectionViewDefaultCategories {
            moveCategoryToSelectedCategoriesCollection(indexPath: indexPath)
        }
        
        if collectionView == categoryView.collectionViewSelectedCategories {
            moveItemToDefaultCategoriesCollection(indexPath: indexPath)
        }
    }
    
}
