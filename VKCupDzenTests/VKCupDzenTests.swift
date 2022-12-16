//
//  VKCupDzenTests.swift
//  VKCupDzenTests
//
//  Created by Павел Кай on 16.12.2022.
//

import XCTest
@testable import VKCupDzen

extension CategoryModel.Category: Comparable {
    public static func == (lhs: CategoryModel.Category, rhs: CategoryModel.Category) -> Bool {
        return lhs.categoryName == rhs.categoryName
    }
    
    
    public static func < (lhs: VKCupDzen.CategoryModel.Category, rhs: VKCupDzen.CategoryModel.Category) -> Bool {
        return lhs.categoryName < rhs.categoryName
    }
    
}

final class VKCupDzenTests: XCTestCase {
    
    func testResetCategoreis() throws {
        var categoryModel = CategoryModel()
        
        for _ in 0...categoryModel.categories.count - 1 {
            categoryModel.setCategorySelected(which: 0)
        }
        
        categoryModel.resetCategories()
        XCTAssertTrue(categoryModel.selectedCategories.isEmpty)
    }
    
    func testAddCategoryToSelected() throws {
        var categoryModel = CategoryModel()
        
        categoryModel.setCategorySelected(which: 0)
        categoryModel.setCategorySelected(which: 0)
        categoryModel.setCategorySelected(which: 0)
        
        XCTAssertEqual(3, categoryModel.selectedCategories.count)
    }
    
    func testDeleteCategoryFromSelected() throws {
        var categoryModel = CategoryModel()
        
        categoryModel.setCategorySelected(which: 0)
        categoryModel.setCategorySelected(which: 0)
        categoryModel.setCategorySelected(which: 0)
        
        categoryModel.setCategoryDeselected(which: 0)
        categoryModel.setCategoryDeselected(which: 0)
        categoryModel.setCategoryDeselected(which: 0)
        
        XCTAssertEqual(0, categoryModel.selectedCategories.count)
    }
    
    func testAreCategoriesEqual() throws {
        let categoryModel = CategoryModel()
        
        let createdCategories = categoryModel.categories.sorted()
        let categories = categoryModel.getCategories().sorted()
        
        XCTAssertEqual(createdCategories, categories)
    }
    
    func testDeleteCategoryFromSelectedAtIndex() throws {
        var categoryModel = CategoryModel()
        
        categoryModel.setCategorySelected(which: 0)
        categoryModel.setCategorySelected(which: 0)
        categoryModel.setCategorySelected(which: 0)
        
        let selectedItem = categoryModel.selectedCategories[1]
        categoryModel.setCategoryDeselected(which: 1)
        
        XCTAssertTrue(!categoryModel.selectedCategories.contains(selectedItem))
    }
    
}
