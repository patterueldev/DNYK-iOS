//
//  CategoryRepository.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol CategoryRepository {
    func getCategories() async throws -> [CategoryModel]
}
