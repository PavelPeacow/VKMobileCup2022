//
//  Category.swift
//  SomeVKCupProject
//
//  Created by Павел Кай on 15.12.2022.
//

import Foundation

struct CategoryModel {
    private(set) var categories = [Category]()
    private(set) var selectedCategories = [Category]()
    
    struct Category {
        let categoryName: String
    }
    
    init() {
        categories = getCategories()
    }
    
}

extension CategoryModel {
    
    mutating func setCategorySelected(which index: Int) {
        selectedCategories.insert(categories[index], at: 0)
        categories.remove(at: index)
    }
    
    mutating func setCategoryDeselected(which index: Int) {
        categories.insert(selectedCategories[index], at: 0)
        selectedCategories.remove(at: index)
    }
    
    mutating func resetCategories() {
        selectedCategories.removeAll()
        categories = getCategories()
    }
    
    func getCategories() -> [Category] {
        
        return [
            Category(categoryName: "Юмор"),
            Category(categoryName: "IT"),
            Category(categoryName: "Кино"),
            Category(categoryName: "Сериалы"),
            Category(categoryName: "Еда"),
            Category(categoryName: "Автомобили"),
            Category(categoryName: "Политика"),
            Category(categoryName: "Новости"),
            Category(categoryName: "Смешные видео с котиками"),
            Category(categoryName: "Животные"),
            Category(categoryName: "Рестораны"),
            Category(categoryName: "Спорт"),
            Category(categoryName: "Отдых"),
            Category(categoryName: "Жизнь"),
            Category(categoryName: "Охота"),
            Category(categoryName: "Учеба"),
            Category(categoryName: "Компьютеры"),
        ].shuffled()
        
    }
    
    func showAllSelectedCategories() -> String {
        var selectedCategoriesMessage = ""
        selectedCategories.forEach { selectedCategoriesMessage += "\($0.categoryName), " }
        selectedCategoriesMessage.removeSubrange(selectedCategoriesMessage.lastIndex(of: ",")!...)
        selectedCategoriesMessage.append(".")
        return selectedCategoriesMessage
    }
    
}
